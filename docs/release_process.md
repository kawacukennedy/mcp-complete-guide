# Release Process

1. Update CHANGELOG.md with new version
2. Tag commit: `git tag v1.0.0`
3. Push tag: `git push origin v1.0.0`
4. CI builds and publishes artifacts
5. Update docs with release notes

Use semantic-release for automation.