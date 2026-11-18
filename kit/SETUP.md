# Setup interview

You are installing a second brain for a new owner. Your job: ask what you need, then generate a brain tuned exactly to them. Read this whole file before asking the first question.

## How to run the interview
- Use the **AskUserQuestion** tool for every choice (up to 4 questions per call, 2 to 4 options each; "Other" is added automatically for free text). For open answers (names, goals, course lists, writing samples), ask in plain chat and wait.
- Go round by round. Keep each message short and friendly. Never ask something you can already infer from an earlier answer.
- Say up front: "About 10 minutes, 8 short rounds. You can say 'skip' to anything."
- If `brain.config.json` already exists, this is a **re-run**: read it and `CLAUDE.local.md` first, ask which parts they want to change, and only redo those rounds. Never delete their data folders.

## Round 1: Identity
1. **What should your brain be called?** Offer 3 suggestions plus Other, e.g. "<First name>'s Brain", "Atlas", "Second Brain". This name replaces every generic title: the heading of `CLAUDE.local.md`, `NOW.md`, the README they see.
2. Their name, and what you should call them.
3. Pronouns (they/them by default if skipped).
4. Where they live, and their timezone (IANA name, e.g. `Asia/Singapore`, `America/Toronto`). Ask if they need a **second clock** (family abroad, moving soon, a partner overseas); if so get its label and IANA zone.

## Round 2: Life right now
1. Stage: school or university / working / national service or military / gap year / mixed / other.
2. Institution, programme or employer (whatever applies).
3. Goals: what they want in the next 12 months, and the long-term goal (3 to 10 years).
4. Anything already decided that you should **never reopen** (settled decisions), with the reason.
5. Big upcoming events in the next 6 months with dates (moves, exams, applications, trips).

## Round 3: Modules (multiSelect)
Ask which areas the brain should manage. Each module is described in `kit/modules/<name>.md`, which lists its follow-up questions, the files to create and the index rows to add.

| Module | Folder |
|---|---|
| `school` (courses, exams, grades, study drills) | `02-school/` |
| `work` (job, projects at work, career moves) | `03-work/` |
| `research` (research interests, labs, papers, contacts) | `04-research/` |
| `projects` (side projects, builds, hackathons) | `05-projects/` |
| `fitness` (workouts, running, nutrition targets) | `06-fitness/` |
| `health` (appointments, medication, conditions they choose to track) | `07-health/` |
| `money` (budget, scholarships, banking, income) | `08-money/` |
| `home` (housing, moves, admin, documents, visas) | `09-home/` |
| `applications` (admissions, jobs, scholarships to apply for) | `10-applications/` |
| `people` (contacts, birthdays, who to ask about what) | lives in `01-profile/` |

AskUserQuestion allows only 4 options per question, so split this into 3 multiSelect questions in one call (for example: study and work / body and money / life admin and people). Then, for each chosen module, read its `kit/modules/<name>.md` and ask its follow-up questions (batch them; at most 2 rounds total for all modules).

## Round 4: How you should answer
1. Length: very concise (lead with the answer, bullets, no filler) / balanced / detailed explanations.
2. Tone: casual (swearing fine) / casual (clean) / professional.
3. Spelling: British or Canadian / American.
4. Maths: LaTeX (their editor renders it) / plain Unicode (terminal). Ask only if `school`, `research` or `work` is technical.
5. Anything that annoys them in AI answers (free text, optional). Turn each answer into an explicit rule.

## Round 5: Their writing voice (optional)
Ask them to paste 1 to 3 things they wrote themselves (an essay paragraph, a bio, an email). Distil a **voice rule** used whenever you write *as* them: person, sentence length, formality, signature phrases, things they never do (dashes, emojis, slang), spelling. Quote 2 or 3 calibration sentences verbatim. If they skip, write "No voice sample yet; ask for one the first time you draft something in their name."

## Round 6: Shared account check (important)
Ask exactly: **"Does anyone else use this same Claude account (for example a sibling or partner)?"**
- **Yes, shared:** the account's Google connectors (Gmail, Calendar, Drive, Sheets) are connected to the *other person's* Google account. Set `"google_connectors": false`. Write `.claude/settings.local.json` as:
  ```json
  {
    "permissions": {
      "deny": [
        "mcp__claude_ai_Gmail",
        "mcp__claude_ai_Google_Calendar",
        "mcp__claude_ai_Google_Drive",
        "mcp__claude_ai_Google_Sheets"
      ]
    }
  }
  ```
  Merge with the file if it already exists. Tell them: their dates live in `00-dashboard/deadlines.md`, `/sweep` is off, and `/weekly-review` runs from files only. Add a hard rule at the top of `CLAUDE.local.md`: "This account is shared. Never use Gmail, Google Calendar, Google Drive or Google Sheets tools; they belong to someone else."
- **No, it's mine:** ask which connectors they actually use (multiSelect: Gmail, Google Calendar, Google Drive, none). Set `"google_connectors": true` and list them in `"connectors"`. If Gmail is on, ask which senders matter most to them (school system, manager, recruiters) and write them into `00-dashboard/inbox-sweep.md` as their sweep focus.

## Round 7: Reminders (multiSelect)
- Live clock line on every message (recommended).
- Birthday reminders the day before and the day of (only offer if `people` is on; ask them to list birthdays as `MM-DD Name`, or say they will add them later).
- Weekly review nudge. Ask which day (default Sunday).

## Round 8: Confirm
Show a one-screen summary: brain name, modules, answer style, shared-account status, reminders. Ask "Build it?" with options Build / Change something.

## Generate
Do all of this in one pass, then verify.

1. **`brain.config.json`** at the root:
   ```json
   {
     "brain_name": "", "owner_name": "", "pronouns": "",
     "timezone": "Area/City", "timezone_label": "",
     "second_timezone": null,
     "modules": [],
     "google_connectors": false, "connectors": [],
     "hooks": {"time": true, "birthdays": false, "weekly_review": true},
     "weekly_review_day": 6,
     "birthdays_file": "01-profile/birthdays.md",
     "kit_version": "<top version in kit/CHANGELOG.md>",
     "installed": "YYYY-MM-DD"
   }
   ```
   `second_timezone` is `{"label": "...", "tz": "Area/City"}` or `null`. `weekly_review_day`: Monday 0 to Sunday 6.
2. **`CLAUDE.local.md`** from `kit/templates/CLAUDE.local.template.md`: fill every `{{...}}`, delete template comments, add one index row per file you create (module files give their rows). The answer-style rules and voice rule go in verbatim. No placeholder may survive.
3. **Always create:** `00-dashboard/NOW.md`, `00-dashboard/deadlines.md`, `01-profile/profile.md` from `kit/templates/`, filled with what they told you. Every dated event from the interview goes into `deadlines.md`; anything in the next 7 days also into NOW.md URGENT. Create `01-profile/birthdays.md` if `people` is on, and `00-dashboard/inbox-sweep.md` if Gmail is on.
4. **Each module:** create the folder and the files listed in its `kit/modules/<name>.md`, pre-filled with their answers. Leave a `> To fill:` line for anything they skipped. Do not create folders for modules they did not choose.
5. **`.claude/settings.local.json`** only if the account is shared (Round 6).
6. **Verify:** `grep -rn "{{" CLAUDE.local.md 0*/ 1*/` must print nothing. Run `CLAUDE_PROJECT_DIR="$PWD" python3 kit/hooks/prompt.py < /dev/null` and check it prints the time line (and nothing about setup). If python3 is missing, tell them hooks need it (`xcode-select --install` on a Mac) and continue.
7. **Finish** with: the brain's name, the folders created, and these next steps:
   - "Start a fresh Claude chat in this folder (or reload VS Code) so the new rules and reminders load."
   - "Just talk to it. Tell it about your week, paste a syllabus, forward a deadline; it files things itself."
   - "Run `/update-brain` now and then to get improvements."

Never put secrets (passwords, ID numbers, bank details) into files unless they insist; suggest storing only the last 4 digits.
