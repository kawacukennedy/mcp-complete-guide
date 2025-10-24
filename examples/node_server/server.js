// (Same structure as earlier but include JWT auth, simple policy check, and WS streaming example)
const express = require('express');
const bodyParser = require('body-parser');
const http = require('http');
const WebSocket = require('ws');
const fs = require('fs');
const jwt = require('jsonwebtoken');

const MANIFEST = JSON.parse(fs.readFileSync(__dirname + '/../spec/manifest_example.json'));
const app = express();
app.use(bodyParser.json());

// Simple JWT auth middleware for demo
function authMiddleware(req,res,next){
  const auth = req.headers['authorization'];
  if(!auth) return res.status(401).json({error:'missing_auth'});
  const token = auth.split(' ')[1];
  try{
    // NOTE: in prod verify with JWKS
    const payload = jwt.verify(token, 'demo-secret');
    req.user = payload;
    next();
  }catch(e){
    return res.status(401).json({error:'invalid_token'});
  }
}

app.get('/manifest', (req,res)=>res.json(MANIFEST));
app.post('/invoke', authMiddleware, (req,res)=>{
  const { params } = req.body;
  const tool = params?.tool;
  // capability-level scope enforcement
  const cap = MANIFEST.capabilities.find(c=>c.name===tool);
  if(cap && cap.scopes){
    const scopes = req.user?.scopes || [];
    const ok = cap.scopes.every(s=>scopes.includes(s));
    if(!ok) return res.status(403).json({error:'insufficient_scope'});
  }
  if(tool==='reverse'){
    const text = params.input?.text||'';
    return res.json({ jsonrpc:'2.0', id: req.body.id||'1', result: { reversed: text.split('').reverse().join('') } });
  }
  return res.status(400).json({ error:'unknown_tool' });
});

const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

wss.on('connection', (ws) => {
  ws.send(JSON.stringify({ type:'manifest', manifest: MANIFEST }));
  ws.on('message',(msg)=>{ ws.send(JSON.stringify({ type:'echo', payload:msg })); });
});

server.listen(8081, ()=>console.log('Node MCP server listening on 8081'));
