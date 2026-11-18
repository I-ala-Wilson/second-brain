# Second Brain

A personal second brain that runs inside Claude Code. It remembers your deadlines, courses, goals, projects and preferences in plain Markdown files, answers the way you like, and keeps itself up to date as you talk to it. A short interview tunes it to you, including its name.

## Install (2 minutes, then a 10 minute interview)
You need Claude Code (the VS Code extension or the terminal app) and `git`.

**Easiest:** make an empty folder, open it in VS Code, start Claude, and paste:

```
Clone https://github.com/I-ala-Wilson/second-brain.git into this folder (git clone <url> .), then read kit/SETUP.md and run the setup interview.
```

**Manual:**
```bash
git clone https://github.com/I-ala-Wilson/second-brain.git my-brain
cd my-brain
claude
```
Then type `/setup`.

When setup finishes, start a new Claude chat in the folder (or reload VS Code) so your rules and reminders load.

## Using it
- Just talk to it: "my chem midterm moved to the 12th", "paste: syllabus", "what's due this week?", "plan my gym week".
- `/weekly-review`: next 14 days, open threads, top 3 for the week.
- `/sweep`: reads your Gmail for deadlines and replies you owe (only if you enabled Gmail).
- `/update-brain`: pulls improvements to the kit. Your own files are never touched by updates.
- `/setup`: change your answers later (name, modules, style).

## Sharing a Claude account with someone?
Setup asks this. If the account is shared, its Gmail, Google Calendar, Drive and Sheets connectors belong to the other person, so your brain is locked out of them (enforced with deny rules in `.claude/settings.local.json`). Your dates live in the brain's own `deadlines.md` instead.

## What lives where
| Path | What |
|---|---|
| `CLAUDE.md` | Shared engine rules (updated by `/update-brain`, don't edit) |
| `CLAUDE.local.md` | Your brain: name, index, answer style, voice, rules (private) |
| `brain.config.json` | Your settings: timezone, modules, reminders (private) |
| `00-dashboard/`, `01-profile/`, `02-…` | Your notes (private) |
| `kit/` | Installer, templates, modules, hooks |

Everything personal is gitignored, so nothing you write is ever pushed anywhere. Back it up yourself (iCloud Drive, a private repo) if you want.

## Requirements
- Python 3 for the reminder hook (`xcode-select --install` on a Mac if `python3` is missing).
