---
description: Pull the latest second-brain kit and apply any migrations
---

1. Run `git status --porcelain`. Personal files are gitignored, so normally nothing shows. If a tracked kit file was edited locally, show the diff and ask before discarding it (`git checkout -- <file>`).
2. Note the current `kit_version` in `brain.config.json`, then run `git pull --ff-only`. If it fails because the repo is private or unreachable, say so in one line and stop; their brain keeps working as is.
3. Read `kit/CHANGELOG.md`. For every version newer than their `kit_version`, apply its **Migration** steps to their personal files (never overwrite their content; add or rename only as the steps say). Then set `kit_version` to the newest version.
4. Report what changed in 3 bullets or fewer, and tell them to start a fresh chat if `CLAUDE.md`, hooks or commands changed.
