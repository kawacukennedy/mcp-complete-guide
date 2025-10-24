import http from 'k6/http';
import { sleep } from 'k6';
export default function(){
  http.post('http://localhost:8080/invoke', JSON.stringify({jsonrpc:'2.0', id:'lt', params:{tool:'get_time', input:{}}}), {headers:{'Content-Type':'application/json'}});
  sleep(1);
}
