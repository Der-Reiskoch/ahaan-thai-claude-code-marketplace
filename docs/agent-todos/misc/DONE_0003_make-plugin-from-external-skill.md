---
title: Make plugin from external skill
status: done
---

## Tasks

- [x] create a new Plugin `skill-sharing` with a skill of the same name
- [x] the skill can be found in an external repo `~/Projects/foodie/ahaan-thai/.claude/skills/skill-sharing`
- [x] there is a script call inside the skill, make it path agnostic with <base_directory> like it is done in other skills (for example: `plugins/thai-cook-book-library/skills/thai-cookbook-detailing/SKILL.md`)
- [x] update the marketplace file, readme.md, claude.md

## Progress, Decisions etc.

### 2026-02-03: Plugin Created

**What was done:**

- Created plugin structure at `plugins/skill-sharing/`
- Created `.claude-plugin/plugin.json` with metadata
- Created `skills/skill-sharing/SKILL.md` with `<base_directory>` pattern for script invocation
- Adapted `scripts/sync-skills.sh` to use `$PWD` as project root (instead of calculating from script location)
- Updated `marketplace.json` with new plugin entry
- Updated `README.md` with plugin in the Available Plugins table
- Updated `CLAUDE.md` with plugin in the Available Plugins table

**Decisions made:**

- Used `$PWD` as project root instead of calculating from script location. This is necessary because when the script is installed as a plugin, it will be in the plugin cache directory, not the user's project. The user must run the script from their project root.
- Kept the skill name `skill-sharing` as it follows the noun+gerund naming convention.
- Description: "Share Claude Code skills with other AI agents"

**Files created:**

- `plugins/skill-sharing/.claude-plugin/plugin.json`
- `plugins/skill-sharing/skills/skill-sharing/SKILL.md`
- `plugins/skill-sharing/skills/skill-sharing/scripts/sync-skills.sh`
