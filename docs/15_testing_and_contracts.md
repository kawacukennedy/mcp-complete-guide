# Testing & contract verification

## Contract tests
- Use `spec/*.schema.json` to validate `/manifest` and `/invoke` responses.
- Add a `tests/contract/test_manifest_contract.py` that requests `/manifest` and validates schema.

## Fuzz tests
- Use Atheris (Python) or boofuzz for JSON inputs; the repo must include a simple atheris harness demo under `tests/fuzz/`.

## Load testing
- Add k6 script and basic instructions to run locally and in CI if load-tests are desired.
