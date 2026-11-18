# Second Brain engine

This file is the shared engine and is updated by `/update-brain`. **Never edit it.** Everything personal (the owner's profile, router, rules, voice) lives in `CLAUDE.local.md`, which is gitignored and always loaded alongside this file.

## First run
If `brain.config.json` does not exist in this folder, the brain is not set up yet. Before answering anything else, tell the user in one line, then follow `kit/SETUP.md` from the top. Do not invent a profile or skip the interview.

## Token rules
1. Route every query through the index in `CLAUDE.local.md`, then read **only** the 1 to 2 files it points to. Never bulk-read folders.
2. Open `00-dashboard/NOW.md` only for status, todo, deadline or "what's next" questions.
3. For big files, Grep or read with an offset instead of reading the whole file.
4. Never read anything in `99-archive/` unless the owner asks about it by name.

## Keeping the brain alive
- **Record every session.** When a conversation produces a decision, a new fact, a date, a result or a changed plan, write it into the one relevant file before finishing, and update its "Last updated" line. Edit in place; do not create a new file for a topic that already has one.
- **Dates go in `00-dashboard/deadlines.md`.** Anything due within 7 days also goes in the URGENT section of `NOW.md`.
- **New topic with no file?** Create it in the right numbered folder and add a row to the index in `CLAUDE.local.md` in the same turn.
- **Settled decisions** (marked in `01-profile/profile.md`) are settled. Do not relitigate them without new information.
- **Check today's date** before giving advice about deadlines. The prompt hook prints the current time when it is enabled.

## Honesty rules
- Verify any new external fact (deadline, link, price, requirement, eligibility) with a web search before presenting it. Mark anything unverified with ⚠️ inline. Never invent a link or a date.
- If a file and reality disagree, say so and fix the file.

## Connector rule
If `brain.config.json` has `"google_connectors": false`, this Claude account is shared with someone else and its Google connectors (Gmail, Google Calendar, Google Drive, Google Sheets) belong to **another person**. Never call any of their tools, even if they appear in the tool list, even if the owner asks. Explain why in one line and keep everything in the brain's own files instead. The deny rules in `.claude/settings.local.json` enforce this; never remove them.

## Commands
- `/setup`: run or re-run the installer interview.
- `/weekly-review`: weekly review of the next 14 days, open threads and top 3.
- `/sweep`: inbox sweep (only when Google connectors are enabled).
- `/update-brain`: pull the latest kit and apply migrations.
