---
name: officialwhitebird-boundary-skills
description: "Use when Codex or another local coding agent needs to audit AI-run boundaries with officialwhitebird CLI tools: checking work instructions with handoff-lint, classifying proposed commands with policy-lint, verifying contract/result records with contract-lint, scanning public README/release copy with claim-lint, or running a full local four-boundary case study."
---

# officialwhitebird Boundary Skills

Use this skill to route an AI-run boundary question to the correct local officialwhitebird CLI.

## Workflow

1. Identify the boundary the user is asking about.
2. Locate the relevant file or command string.
3. Check whether the underlying CLI is available.
4. Run only the matching checker unless the user asks for a full run package audit.
5. Report the command, exit code, blocking findings, warnings, owner decisions still required, and unresolved risks.

## Boundary Routing

| User asks about | Run |
|---|---|
| work instruction, handoff, scope, acceptance criteria | `handoff-lint check <instruction.md>` |
| proposed shell command or execution permission | `policy-lint classify --policy <policy.json> "<command>"` |
| completed result vs declared contract | `contract-lint verify --contract <contract.json> --result <result.json>` |
| public README, release notes, or social copy | `claim-lint scan <file.md> --config <.claimlintrc.json>` |
| full run package | run the applicable checks in this order: handoff, policy, contract, claims |

## Guardrails

- Do not claim the tools prove semantic correctness.
- Do not claim the tools enforce security boundaries.
- Do not run external, paid, destructive, publication, or background actions without explicit user approval.
- If a CLI is missing, report the missing dependency and show the install or local checkout path instead of inventing a replacement check.
- Keep internal names, private paths, and run ids out of public-facing copy.

## Full Case Study

For this repository's bundled fixture set, run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/run-case-study.ps1
```

Read `references/boundary-routing.md` for routing details and `references/underlying-cli-install.md` for local development setup.
