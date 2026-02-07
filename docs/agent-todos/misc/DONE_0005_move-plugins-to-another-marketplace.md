---
title: Move plugins to another marketplace
status: done
---

## Context

We have two plugins `plugins/khao-pad-dev-skills` and `plugins/khao-pad-dev-mcp-servers` that do not fit in this specialized market place, so we want to move the to more general purpose marketplace

## Tasks

- [x] We prepared an empty repo `~/Projects/foodie/khao-pad-skills/`
- [x] Make this a new repo a marketplace (see `.claude-plugin` as a template)
- [x] The name should be `khao-pad-skills`
- [x] Move both `plugins/khao-pad-dev-skills` and `plugins/khao-pad-dev-mcp-servers` to the new marketplace repo
- [x] Register them in the new marketplace
- [x] Remove any traces in the current repo
- [x] Update all documentation files that reference `plugins/khao-pad-dev-skills` and `plugins/khao-pad-dev-mcp-servers`
- [x] Update the new marketplace's `README.md` (using this repo's `README.md` as template)

## Progress, Decisions etc.

### 2026-02-07: Task activated and status corrected

**What was done:**

- Confirmed this is the active follow-up migration task for `khao-pad-dev-skills` and `khao-pad-dev-mcp-servers`
- Corrected inconsistent state from `status: done` to `status: doing` while keeping open-task filename `0005_...`
- Prepared the task for execution and overview synchronization

**Decisions made:**

- Keep this file as the active task record and do not mark as `DONE_` until migration work is actually completed

### 2026-02-07: Migration completed

**What was done:**

- Created `khao-pad-skills` marketplace scaffold in `/Users/jens/Projects/foodie/khao-pad-skills` with `.claude-plugin/marketplace.json`
- Migrated plugin folders:
  - `plugins/khao-pad-dev-skills`
  - `plugins/khao-pad-dev-mcp-servers`
- Created/updated `/Users/jens/Projects/foodie/khao-pad-skills/README.md` with marketplace install and plugin install instructions
- Removed migrated plugin entries from `.claude-plugin/marketplace.json` in this repository
- Removed migrated plugin references from:
  - `README.md`
  - `CLAUDE.md`
  - `AGENTS.md`
- Removed plugin directories from this repository:
  - `plugins/khao-pad-dev-skills`
  - `plugins/khao-pad-dev-mcp-servers`

**Decisions made:**

- Used copy + delete for cross-repo migration (explicitly approved) because direct `git mv` across repositories is not possible
- Kept `ahaan-thai-plugins` marketplace focused on Thai food plugins only
