---
name: decisions
description: Manage the repo's strategic and architectural decision log in docs/decisions/. Use BEFORE starting non-trivial work (new feature, refactor, dependency or architecture change) to read the index and check for constraints. Use AFTER a significant choice is made (a technology, boundary, convention, or rejected approach) to propose recording it. Also use when asked "why did we do X", or when a proposal might contradict a past decision.
---

# Decisions

A lightweight decision log so every agent knows the approach already chosen, and why.

## Layout

```
docs/decisions/
  index.md          # one line per record
  0001-short-title.md
  0002-short-title.md
```

If `docs/decisions/` does not exist, create it with an empty `index.md` (see `templates/index.md`) the first time a decision is recorded.

## Before starting work

1. Read `docs/decisions/index.md` only.
2. Open only the records whose summary touches your task.
3. Treat `accepted` records as constraints. Do not re-propose a rejected alternative.
4. If your plan conflicts with an accepted decision, stop and tell the user. Do not work around it silently.
5. Ignore `superseded` records except to understand history. Follow the one that supersedes them.

## What deserves a record

Record it if at least one is true:

- Hard or expensive to reverse (datastore, framework, cloud, API shape).
- It constrains future work (architecture boundary, layering rule, "never do X").
- A reasonable engineer would have chosen differently (a library deliberately avoided).
- An agent would likely get it wrong without being told.

Do not record anything obvious from the code, easily reversible, or purely tactical (variable names, one-off fixes, formatting handled by a linter).

## Recording a decision

1. Read `index.md` and check for conflicts or duplicates.
2. Draft the record from `templates/decision.md` with the next sequential number. Keep it under about 30 lines.
3. Always include **Alternatives rejected** with the reason for each. This is the most valuable section.
4. Set status to `proposed` and show the draft to the user. Only the user can move it to `accepted`. Never accept your own proposal.
5. On acceptance, add one line to `index.md`: number, title, status, one-sentence summary.

## Changing a decision

Never edit the substance of an accepted record. Instead:

1. Write a new record that explains what changed and why.
2. In the old record, change status to `superseded by NNNN` and add a link.
3. In the new record, add `Supersedes: NNNN`.
4. Update both lines in `index.md`.

Typo and link fixes are fine to edit in place.
