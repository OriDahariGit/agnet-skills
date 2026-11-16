# init-project-rules

A user-invoked skill that creates or updates a project's agent instructions file (CLAUDE.md or AGENTS.md) with rules you have explicitly confirmed.

## What it does

1. Finds the target file in the current directory, or asks which one to create.
2. Scans the project read-only: structure, configs, tests, docs, and inconsistencies.
3. Builds a list of candidate rules from what it found.
4. Interviews you, one topic at a time, until you both agree on the full rule set.
5. Drafts only the confirmed rules under a "Project Rules" section.
6. Adds a standing rule: stop and ask before changing the file or conflicting with it.
7. Shows you the diff and saves only after you say yes.

## How to use it

Open your agent in the project repo root and invoke the skill explicitly, for example with the slash command `/init-project-rules`. The agent cannot start it on its own, because the skill sets `disable-model-invocation: true`.

## Re-running

On a project that already has rules, existing rules are treated as confirmed. The skill looks for drift between the rules and the code, and interviews you only about the differences. It never removes or changes an existing rule without asking.

## Principles

- You own the rules, the agent owns the questions.
- Nothing is written that you have not confirmed.
- Nothing is saved without showing you the diff first.