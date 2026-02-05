# Adjust Skills to Naming Convention

## Problem / Context

The CLAUDE.md now defines a skill naming convention using the **noun + gerund** pattern (e.g., `term-parsing`, `entry-finding`). Several existing skills in both the local `.claude/skills/` folder and plugin skills don't follow this convention.

Exception: `init` is an accepted short form (like `git init`, `/init`), so `todo-init` is valid.

## Skills to Rename

### Local Skills (`.claude/skills/`)

- [x] `todo-importing` - already follows convention
- [x] `todo-processing` - already follows convention
- [x] `todo-init` - valid (init exception)

### Plugin Skills

| Plugin | Current Name | New Name |
|--------|--------------|----------|
| `thai-tools` | `ask-clickthai` | `clickthai-querying` |
| `thai-food-dictionary` | `thai-term-parser` | `thai-term-parsing` |
| `thai-food-dictionary` | `thai-transliteration-parser` | `thai-trans-parsing` |
| `thai-food-encyclopedia` | `thai-food-encyclopedia-finder` | `thaifood-encyclopedia-finding` |
| `thai-cook-book-library` | `thai-cook-book-details` | `thai-cookbook-detailing` |
| `khao-pad-dev-skills` | `ui-components` | `khao-component-rendering` |
| `khao-pad-dev-skills` | `style-with-css` | `khao-styling` |

## Tasks

- [x] Confirm new names with user before renaming
- [x] Rename each skill folder
- [x] Update the `name` field in each SKILL.md frontmatter
- [x] Update any cross-references in SKILL.md files (none found)
- [x] Update CLAUDE.md if it references old skill names (no references found)
- [x] Bump version in each affected plugin's `plugin.json`
- [x] Bump version in `.claude-plugin/marketplace.json`
- [x] Test that renamed skills still work

## Progress, Decisions etc.

### 2026-02-03: Todo created

Created this todo to track the skill renaming work. Local skills already follow the convention. Seven plugin skills need to be renamed.

### 2026-02-03: Names confirmed by user

All new names confirmed:
- `clickthai-querying` (fits the pattern)
- `thai-term-parsing`
- `thai-trans-parsing`
- `thaifood-encyclopedia-finding`
- `thai-cookbook-detailing`
- `khao-component-rendering`
- `khao-styling`

### 2026-02-03: Renaming completed

**Folders renamed:**
- `ask-clickthai` → `clickthai-querying`
- `thai-term-parser` → `thai-term-parsing`
- `thai-transliteration-parser` → `thai-trans-parsing`
- `thai-food-encyclopedia-finder` → `thaifood-encyclopedia-finding`
- `thai-cook-book-details` → `thai-cookbook-detailing`
- `ui-components` → `khao-component-rendering`
- `style-with-css` → `khao-styling`

**SKILL.md updates:**
- Updated `name` field in all 7 SKILL.md files
- Added proper YAML frontmatter to khao-pad-dev-skills SKILL.md files (they were missing it)

**Version bumps:**
- `thai-tools`: 0.0.3 → 0.0.4
- `thai-food-dictionary`: 0.0.3 → 0.0.4
- `thai-food-encyclopedia`: 0.0.3 → 0.0.4
- `thai-cook-book-library`: 0.0.3 → 0.0.4
- `khao-pad-dev-skills`: 0.0.1 → 0.0.2
- `marketplace`: 0.1.0 → 0.2.0

### 2026-02-03: Testing completed

All scripts tested successfully:
- `clickthai-querying` - runs without errors
- `thai-term-parsing` - correctly parses Thai terms
- `thai-trans-parsing` - correctly parses transliterations
- `thaifood-encyclopedia-finding` - finds encyclopedia entries
- `thai-cookbook-detailing` - returns cookbook details
- `khao-component-rendering` - knowledge-based skill (no script)
- `khao-styling` - knowledge-based skill (no script)

**Task complete.**
