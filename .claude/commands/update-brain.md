---
description: Pull the latest second-brain kit and apply any migrations
---

1. Run `git status --porcelain`. Personal files are gitignored, so normally nothing shows. If a tracked kit file was edited locally, show the diff and ask before discarding it (`git checkout -- <file>`).
2. Note the current `kit_version` in `brain.config.json`, then run `git pull --ff-only`. If it fails because the repo is private or unreachable, say so in one line and stop; their brain keeps working as is.
3. **Brain Chat:** if `kit/CHANGELOG.md` lists a Brain Chat version newer than the one installed (`code --list-extensions --show-versions | grep brain-chat`; on macOS the `code` tool may be at `/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code`), re-run the extension step by running `bash kit/install.sh` (macOS) or `powershell -ExecutionPolicy Bypass -File kit\install.ps1` (Windows), then tell them to reload VS Code.
4. Read `kit/CHANGELOG.md`. For every version newer than their `kit_version`, apply its **Migration** steps to their personal files (never overwrite their content; add or rename only as the steps say). Then set `kit_version` to the newest version.
5. Report what changed in 3 bullets or fewer, and tell them to start a fresh chat if `CLAUDE.md`, hooks or commands changed.
