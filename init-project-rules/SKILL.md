---
name: init-project-rules 
description: Scan the current project, interview the user about it, then create or update the project's agent instructions file (CLAUDE.md or AGENTS.md). Only run when the user explicitly invokes it. 
disable-model-invocation: true
---

# Init Project Rules

This skill runs only when the user explicitly invokes it. Never invoke it on your own, even if it looks useful.

Goal: produce or extend the project's agent instructions file so that every future session reads strict, confirmed rules about the project, and asks the user before anything in that file changes.

## Core principle

The user owns the rules. You own the questions. Never write a rule into the file that the user has not explicitly confirmed. If something is unclear, ask. Do not guess and do not fill gaps with assumptions.

## Step 1: Locate the target file

Look in the current working directory, which is assumed to be the project repo root.

- If neither CLAUDE.md nor AGENTS.md exists, ask the user which to create.
- If exactly one exists, that is the target.
- If both exist, ask which one is the source of truth.

If the target exists, read it fully before doing anything else. Never overwrite it.

## Step 2: Scan the project

Before asking the user anything, explore the repo read-only. Look at:

- Directory layout and naming conventions.
- Package manifests, lockfiles, and build or task runner configs.
- Language, framework, and tooling configs such as linters, formatters, type checkers, and CI.
- Test setup and where tests live.
- Existing docs, READMEs, contributing guides, and architecture notes.
- Environment and secrets handling, such as example env files and gitignore entries.
- Recurring patterns in the code, such as how modules are organized, how errors are handled, and how things are named.
- Anything inconsistent, such as two competing conventions, dead folders, or config that contradicts the docs.

Do not modify anything during the scan.

## Step 3: Build a candidate list

From the scan, privately build a list of candidates: things that might deserve to be a rule, and things where it is unclear whether they should be. Include:

- Conventions you observed that look deliberate.
- Conventions that look accidental or inconsistent.
- Areas where a wrong move by an agent would be costly, such as migrations, generated files, deployment config, and shared interfaces.
- Gaps, meaning things a strict project would normally specify that this repo does not.

For each candidate, note the evidence from the repo that raised it.

## Step 4: Interview the user

Present a brief summary of what you found, then interview the user about the candidates.

Interview rules:

- Ask one topic at a time, and keep each question short and concrete. Cite the evidence, for example: "I see tests in two places, src/tests and a top-level tests folder. Which is the standard?"
- For each candidate, get a clear verdict: this is a rule, this is not a rule, or this is a rule with changes.
- Follow up on vague answers until the rule can be stated unambiguously.
- Ask about things the scan cannot reveal: hard constraints, forbidden actions, what must never be touched, how the user wants the agent to behave, when to stop and ask, and what done means.
- Keep interviewing until you are confident you and the user are aligned. Before moving on, state back your understanding of the full rule set and ask whether anything is missing or wrong.
- Do not move to writing until the user confirms alignment.

## Step 5: Draft the rules

Write only confirmed rules, in the user's intent and as plainly as possible. Group them under clear headings, such as project structure, conventions, forbidden actions, and workflow.

Place everything inside a managed section headed "Project Rules", so future runs know where to merge. If that section already exists, merge into it rather than duplicating.

## Step 6: Standing rule

Always include this rule in the file, verbatim in spirit:

> Before changing anything in this file, or doing anything that conflicts with it, stop and ask the user for explicit approval. If a task seems to require breaking a rule, say which rule and why, and ask whether to change the rule or adjust the task.

## Step 7: Review and save

Show the user the full diff against the existing file, or the full new file if it is being created. Ask for confirmation. Only save after an explicit yes. If the user requests changes, return to the relevant part of the interview and revise.

## Re-runs

When run on a project that already has rules, treat the existing rules as confirmed. In the scan, look for drift: rules the code no longer follows, and new patterns that are not covered. Interview only about the differences, and never remove or alter an existing rule without asking.
