# decisions

A skill that keeps a lightweight log of a project's strategic and architectural decisions, so every agent knows which approach was already chosen and why.

## What it does

- **Before non-trivial work** (new feature, refactor, dependency or architecture change), the agent reads `docs/decisions/index.md`, opens only the relevant records, and treats accepted decisions as constraints. If its plan conflicts with one, it stops and tells you.
- **After a significant choice** (a technology, boundary, convention, or rejected approach), the agent drafts a record with status `proposed` and shows it to you. Only you can accept it.
- **When you ask "why did we do X"**, the agent answers from the log.

## Layout in your project

    docs/decisions/
      index.md              # one line per record
      0001-short-title.md
      0002-short-title.md

The folder is created with an empty index the first time a decision is recorded.

## What gets recorded

A decision is worth recording if it is hard to reverse, constrains future work, goes against what a reasonable engineer might pick, or is something an agent would likely get wrong without being told. Obvious, easily reversible, or purely tactical choices are left out.

Every record includes **Alternatives rejected** with a reason for each, since that is what stops agents from re-proposing them.

## Changing a decision

Accepted records are never rewritten. A new record supersedes the old one, both are cross-linked, and the index is updated. Typo and link fixes are fine in place.

## Templates

- `templates/decision.md`: the record format.
- `templates/index.md`: the starting index.

## Principles

- You accept decisions; the agent only proposes them.
- The index stays short so agents can read it cheaply before every task.
- History is kept: decisions are superseded, not edited.
