# Agent instructions

This public repository publishes reusable hooks and GitHub Actions workflows for personal apps. Read this file, `README.md`, `docs/operator-guide.md`, and the relevant issue before changing files. Keep documentation and automation text in English. Do not include secrets or internal organization data.

Use a topic branch from `main`, make a focused change, run `./tests/test_hooks.sh` and `pre-commit run --all-files`, and record validation and review results in the pull request. Consumers pin immutable full commit SHAs for reusable workflows and released tags for hooks. Grant workflows only required permissions and never pass secrets to untrusted pull request code.

The maintainer reviews stage results and authorizes merges. Do not create or move version tags without explicit approval.
