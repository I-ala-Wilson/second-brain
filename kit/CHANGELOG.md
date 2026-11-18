# Kit changelog
Newest first. Each version lists what changed and the **Migration** steps `/update-brain` applies to existing brains.

## 1.1.0 (2026-11-18) · Brain Chat 0.2.0
- Brain Chat (the VS Code panel) ships with the kit: `kit/install.sh` / `kit/install.ps1` install it, and it opens by itself on a fresh clone and starts setup.
- Five themes (hypercard, clean, midnight, paper, terminal), accent colours, four home-screen patterns, weather, Next 7 days panel, code runner, local voice typing (`kit/voice-setup.*`). Windows supported.
- Setup gains Look, Extras and Import rounds and resumes if interrupted. Two-week onboarding: one gap-filling question a day. Brain learns rules from corrections. `/look` command.
- **Migration:** add `"setup_complete": true` and this block to `brain.config.json` if missing: `"chat": {"theme": "hypercard", "accent": "", "pattern": "chladni", "icon": "brain", "weather": null, "today": true, "calendar": false, "voice": false, "runner": true, "promptFile": null, "voiceVocab": ""}`. Then offer `/look` and ask for their city for weather. Run the Brain Chat step in /update-brain.

## 1.0.0 (2026-11-18)
- First release: setup interview, 10 modules, shared-account Google lockout, prompt hook (clock, birthdays, weekly review), `/setup`, `/weekly-review`, `/sweep`, `/update-brain`.
- **Migration:** none.
