# Create Todo Skills Plugin

## Problem / Context

The 3 todo skills (`todo-init`, `todo-importing`, `todo-processing`) currently exist only in the local `.claude/skills/` folder. They should also be available as a marketplace plugin so other projects can install and use them.

## Tasks

- [x] Create new plugin directory `plugins/todo-skills/`
- [x] Create `.claude-plugin/plugin.json` with metadata
- [x] Copy/move the 3 skills to the plugin:
  - `todo-init`
  - `todo-importing`
  - `todo-processing`
- [x] Update SKILL.md files if needed for plugin context (no changes needed)
- [x] Add plugin to `marketplace.json`
- [x] Update CLAUDE.md "Available Plugins" table
- [x] Decide: keep local skills as duplicates or remove them? → **Remove local versions**
- [x] Test the plugin skills work correctly

## Notes

- Plugin name suggestion: `todo-skills`
- Description: "Agent todo file management skills"
- These skills have no external scripts - they're instruction-based

## Progress, Decisions etc.

### 2026-02-03: Todo created

Created this todo to track the work of packaging the todo skills as a marketplace plugin.

### 2026-02-03: Plugin created

**Completed:**

- Created `plugins/todo-skills/` directory structure
- Created `plugin.json` with version 0.0.1
- Moved all 3 skills from `.claude/skills/` to plugin
- Added plugin to `marketplace.json`
- Updated CLAUDE.md available plugins table
- Updated CLAUDE.md skills naming convention section (removed project-level skills reference)
- Removed empty `.claude/skills/` directory

**Decision:** Local skills removed, only plugin version remains.
