# Agent Skills

A collection of agent skills for Claude Code. Each skill lives in its own folder with a SKILL.md file.

## Skills

- **init-project-rules**: Scans the current project, interviews the user about it, then creates or updates the project's CLAUDE.md or AGENTS.md with confirmed rules. User-invoked only.

## Layout

    agent-skills/
      sync-skills.sh
      init-project-rules/
        SKILL.md
        README.md
      <another-skill>/
        SKILL.md

## Installation

1. Clone the repo anywhere you like:

       git clone <your-repo-url>
       cd agent-skills

2. Make the script executable and run it:

       chmod +x sync-skills.sh
       ./sync-skills.sh

No editing is needed. The script finds the repo from its own location and symlinks every skill folder containing a SKILL.md into `~/.claude/skills`, so the repo stays the single source of truth.

## Sync script options

- **Dry run**: see what would change without touching anything.

      ./sync-skills.sh --dry-run

- **Custom target folder**: link into a different skills directory, for example a project's own `.claude/skills` folder.

      SKILLS_DIR=/path/to/project/.claude/skills ./sync-skills.sh

The script is safe to re-run. It skips real folders that already exist in the target, fixes links that point to the wrong place, and asks before removing dangling links whose skill no longer exists in the repo.

## Adding a new skill

1. Create a new folder with a SKILL.md inside it.
2. Run `./sync-skills.sh` to link it.
3. Commit and push.

## Requirements

- A Unix-like shell: Linux, macOS, or on Windows either WSL or Git Bash.
- Symlinks must be allowed. On Windows outside WSL, this may require developer mode or an elevated shell.

## Notes

- Skills marked `disable-model-invocation: true` only run when explicitly invoked by the user.
- Each skill may include its own README with usage details.