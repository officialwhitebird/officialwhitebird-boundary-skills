# Publish Checklist

Status: owner-gated. This checklist prepares the public action; it does not approve it.

## Before Owner Gate

- Local case study passes with `powershell -ExecutionPolicy Bypass -File scripts/run-case-study.ps1`.
- Skill validation passes with `quick_validate.py`.
- README claim scan returns no findings.
- Public target scan returns no private paths, internal project names, or date-coded run ids.
- `.gitignore` exists and excludes local Python/cache/environment files.
- Git working tree is clean except for intentional release edits.

## Owner-Gated Publish

- Owner explicitly approves GitHub publication.
- Create `officialwhitebird-boundary-skills` under the `officialwhitebird` account.
- Push this repository.
- Check the GitHub README image and relative links.
- Only after owner approval, update the `officialwhitebird` profile README with the row from `docs/officialwhitebird-readme-update-draft.md`.
- In the profile repository, stage only `README.md`.

## Still Not Included

- No profile update before owner approval.
- No public post before owner approval.
- No hosted service call.
- No claim that the checks enforce security or prove semantic correctness.

