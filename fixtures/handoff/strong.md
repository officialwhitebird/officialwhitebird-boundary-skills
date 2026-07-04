---
goal: Add a status summary to the sample-agent-task README.
scope:
  include:
    - README.md
  exclude:
    - deployment
    - external publication
verification:
  commands:
    - python -m pytest
approval_required_for:
  - publish
  - destructive file operations
---

## Context

The sample-agent-task repository needs a short local status summary. Keep the change limited to documentation.

## Acceptance Criteria

- README.md contains a short status section.
- No deployment, publishing, or external service call is performed.
- Verification command is recorded in the result package.
