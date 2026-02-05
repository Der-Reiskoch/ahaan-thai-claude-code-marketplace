# Improve skill-sharing

## Tasks

- [x] improve the SKILL `plugins/skill-sharing/skills/skill-sharing/SKILL.md` and/or it's script
- [x] when copying local skills we do not copy skill-sharing SKILL
- [x] it should also NOT be copied when copying plugin skills
- [x] so "never copy yourself, skill-sharing!"
- [x] bump the version of the plugin (patch) after you have done that.

## Progress, Decisions etc.

### 2026-02-03: Fixed plugin skill copying

**What was done:**

- Added `if [[ "$skill_name" != "skill-sharing" ]]` check in Step 3 (plugin skills copying) to match the existing check in Step 2 (local skills copying)
- Bumped version from 0.0.1 → 0.0.2 in both `plugin.json` and `marketplace.json`

**Files modified:**

- `plugins/skill-sharing/skills/skill-sharing/scripts/sync-skills.sh` (lines 75-81)
- `plugins/skill-sharing/.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`
