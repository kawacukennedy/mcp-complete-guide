#!/usr/bin/env python3
"""mcpctl — simple CLI for MCP servers
Usage:
  mcpctl manifest http://localhost:8080
  mcpctl invoke http://localhost:8080 get_time '{}'
"""
import sys, requests, json

def manifest(url):
    print(requests.get(url + '/manifest').json())

def invoke(url, tool, payload='{}'):
    body = {'jsonrpc':'2.0','id':'cli-1','params':{'tool':tool,'input':json.loads(payload)}}
    r = requests.post(url + '/invoke', json=body)
    print(r.status_code, r.text)

if __name__=='__main__':
    cmd = sys.argv[1]
    if cmd=='manifest': manifest(sys.argv[2])
    elif cmd=='invoke': invoke(sys.argv[2], sys.argv[3], sys.argv[4] if len(sys.argv)>4 else '{}')
    else: print('unknown')
