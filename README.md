# Second Brain

A personal second brain that runs inside Claude Code. It remembers your deadlines, courses, goals, projects and preferences in plain Markdown files, answers the way you like, and keeps itself up to date as you talk to it. A short interview tunes it to you, including its name and look.

It comes with **Brain Chat**, a VS Code panel for talking to it: real maths (LaTeX), diagrams, interactive graphs, runnable code with a step-through player, local voice typing, five themes, and a home screen with your clock, weather and next 7 days.

## Install (2 minutes, then a 10 minute interview)
You need VS Code, a Claude account, and `git` (macOS: run `xcode-select --install` once if `git` is missing; Windows: install Git from git-scm.com).

**Easiest:** make an empty folder, open it in VS Code, open the Claude Code panel (install the "Claude Code" extension if you don't have it), and paste:

```
Clone https://github.com/I-ala-Wilson/second-brain.git into this folder (git clone <url> .), then read kit/SETUP.md and follow it.
```

Claude installs Brain Chat and asks you to reload VS Code. Brain Chat then opens by itself and walks you through setup.

**Manual:**
```bash
git clone https://github.com/I-ala-Wilson/second-brain.git my-brain
cd my-brain
bash kit/install.sh      # Windows: powershell -ExecutionPolicy Bypass -File kit\install.ps1
```
Open the folder in VS Code and reload the window. Brain Chat opens and starts setup (or type `/setup` in any Claude chat in the folder).

## Using it
- Just talk to it: "my chem midterm moved to the 12th", "paste: syllabus", "what's due this week?", "plan my gym week".
- `/weekly-review`: next 14 days, open threads, top 3 for the week.
- `/sweep`: reads your Gmail for deadlines and replies you owe (only if you enabled Gmail).
- `/update-brain`: pulls improvements to the kit. Your own files are never touched by updates.
- `/setup`: change your answers later (name, modules, style).
- `/look`: change Brain Chat's theme, accent colour or home-screen pattern.
- New chat: Ctrl+Cmd+N (Mac) or Ctrl+Alt+N (Windows), or the Brain Chat button in the status bar.

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
- macOS (Apple Silicon for voice typing) or Windows 10/11.
- Python 3 for reminders, the code runner and voice typing (the installer checks and offers it).
- Voice typing downloads a local Whisper model once (about 1.5 GB on Mac, 500 MB on Windows). Nothing you say leaves your computer.
