# Boundary Routing

Use the smallest checker that matches the user's question.

## Input Boundary

Use `handoff-lint` when the user asks whether a work instruction, agent handoff, or task brief is structurally ready before execution.

```bash
handoff-lint check instruction.md
```

Report missing frontmatter, missing required fields, missing headings, and warnings.

## Execution-Authorization Boundary

Use `policy-lint` when the user asks whether a proposed command can run automatically, needs owner review, or should be rejected.

```bash
policy-lint classify --policy policy.json "git status --short"
```

Classification is not enforcement. Treat `owner_gated`, `reject`, and `forbidden` as decision support for the human operator.

## Execution-Contract Boundary

Use `contract-lint` when the user has a declared contract and a recorded result.

```bash
contract-lint verify --contract contract.json --result result.json
```

This compares recorded outputs, verification records, gates, risks, and external-action logs.

## Public-Copy Boundary

Use `claim-lint` when the user asks to scan public README, release, or social copy.

```bash
claim-lint scan README.md --config .claimlintrc.json
```

This is configured string scanning. It does not evaluate truth semantically.

## Full Run Package

When the user asks for a complete boundary audit, run:

1. `handoff-lint`
2. `policy-lint`
3. `contract-lint`
4. `claim-lint`

Summarize each check in one line, then list only actionable findings.
