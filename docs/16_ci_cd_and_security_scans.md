# CI/CD and security

- Include SBOM generation using `syft` and `grype` or `cyclonedx` outputs.
- Container scanning with `trivy` in CI.
- Dependency scanning (Snyk) configured via GH Actions or scheduled job.
- Build signing and image attestation (cosign) for release pipelines.
