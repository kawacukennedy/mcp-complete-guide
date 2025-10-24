import requests
from jsonschema import validate
import json

MANIFEST_SCHEMA = json.load(open('spec/manifest.schema.json'))

def test_manifest_contract():
    r = requests.get('http://localhost:8080/manifest')
    assert r.status_code==200
    manifest = r.json()
    validate(manifest, MANIFEST_SCHEMA)
