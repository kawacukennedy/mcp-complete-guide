import asyncio
import json
import logging
import os
import uuid
from aiohttp import web
from jsonschema import validate, ValidationError
from prometheus_client import Counter, Histogram, start_http_server
from pythonjsonlogger import jsonlogger

# Structured logging
logger = logging.getLogger('mcp-python')
logHandler = logging.StreamHandler()
formatter = jsonlogger.JsonFormatter('%(asctime)s %(levelname)s %(name)s %(message)s')
logHandler.setFormatter(formatter)
logger.addHandler(logHandler)
logger.setLevel(logging.INFO)

# Prometheus metrics (exposed on :9090 by start_http_server)
INVOCATIONS = Counter('mcp_invocations_total', 'Total invocations', ['tool'])
INVOCATION_LATENCY = Histogram('mcp_invoke_latency_ms', 'Invoke latency ms', ['tool'])

MANIFEST = json.loads(open(os.path.join(os.path.dirname(__file__), '..', '..', 'spec', 'manifest_example.json')).read())

async def manifest(request):
    return web.json_response(MANIFEST)

async def health(request):
    return web.json_response({'status':'ok'})

async def invoke(request):
    try:
        payload = await request.json()
    except Exception as e:
        return web.json_response({'jsonrpc':'2.0','error':{'code':400,'message':'invalid_json'}}, status=400)

    req_id = payload.get('id') or str(uuid.uuid4())
    params = payload.get('params', {})
    tool = params.get('tool')
    input_payload = params.get('input', {})

    capability = next((c for c in MANIFEST['capabilities'] if c['name']==tool), None)
    if not capability:
        return web.json_response({'jsonrpc':'2.0','id':req_id,'error':{'code':404,'message':'unknown_tool'}}, status=404)

    # Validate input schema
    schema_ref = capability.get('input_schema_ref')
    if schema_ref:
        schema_path = os.path.join(os.path.dirname(__file__), '..', '..', schema_ref.lstrip('/'))
        with open(schema_path) as f:
            schema = json.load(f)
        try:
            validate(instance=input_payload, schema=schema)
        except ValidationError as e:
            return web.json_response({'jsonrpc':'2.0','id':req_id,'error':{'code':4001,'message':'validation_failed','details':str(e)}}, status=400)

    INVOCATIONS.labels(tool).inc()
    with INVOCATION_LATENCY.labels(tool).time():
        # Dispatch simple built-in tools
        if tool == 'get_time':
            from datetime import datetime
            result = {'time': datetime.utcnow().isoformat() + 'Z'}
        elif tool == 'echo':
            result = {'echo': input_payload}
        elif tool == 'file_search':
            q = input_payload.get('query','')
            # demo: return stubbed results
            result = {'matches':[{'path':'/var/log/syslog','score':0.93,'snippet':'...'}]}
        else:
            result = {'error': 'not_implemented'}

    logger.info(json.dumps({'event':'invoke','id':req_id,'tool':tool,'result_keys':list(result.keys())}))
    return web.json_response({'jsonrpc':'2.0','id':req_id,'result':result})

app = web.Application()
app.add_routes([web.get('/manifest', manifest), web.post('/invoke', invoke), web.get('/healthz', health)])

if __name__ == '__main__':
    # Start Prometheus metrics server on 9090 for scrape
    start_http_server(9090)
    web.run_app(app, host='0.0.0.0', port=8080)
