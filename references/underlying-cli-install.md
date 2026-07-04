# Underlying CLI Setup

This skill pack wraps existing officialwhitebird CLIs. It does not vendor them.

## Public install shape

When public installation is desired, install each tool from its official repository:

```bash
pip install git+https://github.com/officialwhitebird/handoff-lint.git
pip install git+https://github.com/officialwhitebird/contract-lint.git
pip install git+https://github.com/officialwhitebird/policy-lint.git
pip install git+https://github.com/officialwhitebird/claim-lint.git
```

## Local sibling checkout shape

For local development, keep these repositories as siblings:

```text
Projects/
  officialwhitebird-boundary-skills/
  handoff-lint/
  contract-lint/
  policy-lint/
  claim-lint/
```

The bundled `scripts/run-case-study.ps1` uses `PYTHONPATH` and `python -m` to call sibling checkouts without modifying the Python environment.

## Missing CLI behavior

If a tool is unavailable, stop and report the missing dependency. Do not silently replace it with ad hoc checks.
