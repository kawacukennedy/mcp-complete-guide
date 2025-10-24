import sys
import atheris
import json
from jsonschema import validate, ValidationError

# Fuzz the input validation
schema = {
    "type": "object",
    "properties": {
        "query": {"type": "string"}
    }
}

def test_input(data):
    try:
        input_data = json.loads(data)
        validate(instance=input_data, schema=schema)
    except (json.JSONDecodeError, ValidationError):
        pass  # Expected

atheris.Setup(sys.argv, test_input)
atheris.Fuzz()