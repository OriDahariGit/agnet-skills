# Agent Skills

My personal collection of agent skills for Claude Code. Each skill lives in its own folder with a SKILL.md file.

## Skills

- **init-project-rules** — Scans the current project, interviews me about it, then creates or updates the project's CLAUDE.md or AGENTS.md with confirmed rules. User-invoked only.

## Layout

    agent-skills/
      sync-skills.sh
      init-project-rules/
        SKILL.md
      <another-skill>/
        SKILL.md

## Installation

1. Clone the repo:

```bash
git clone <your-repo-url> ~/dev/agent-skills
```

2. Open `sync-skills.sh` and set the `REPO` variable to the path where you cloned it.

3. Make the script executable and run it:

```bash
chmod +x sync-skills.sh
./sync-skills.sh
```

The script symlinks every skill folder containing a SKILL.md into `~/.claude/skills`, so the repo stays the single source of truth.

## Adding a new skill

1. Create a new folder with a SKILL.md inside it.
2. Run `./sync-skills.sh` to link it.
3. Commit and push.

## Notes

- Skills marked `disable-model-invocation: true` only run when I call them explicitly.
- The sync script skips real folders that already exist in `~/.claude/skills` and asks before removing dangling links.