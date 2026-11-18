---
description: Weekly review: next 14 days, open threads, last week, top 3 for the week
---

Run the owner's weekly review. One screen max, in the answer style from `CLAUDE.local.md`, nothing omitted.

1. **Inbox** (only if `brain.config.json` has `"google_connectors": true` and Gmail in `"connectors"`): run the `/sweep` procedure (`.claude/commands/sweep.md`) for the past 7 days, including its write-backs. Show only its Deadlines and Replies-owed lists. Otherwise skip this step silently.
2. **Next 14 days**, grouped by day: Grep `00-dashboard/deadlines.md` and the URGENT section of `00-dashboard/NOW.md` for dates in the window, plus `01-profile/birthdays.md` if it exists. If Google Calendar is an enabled connector, also list its events for the window.
3. **Open threads**: one line each with the next action and who it is waiting on, from NOW.md "Next up" and "Waiting on others" and any project file with a live status.
4. **Last week**: what got done, from NOW.md "Done recently" entries in the past 7 days.
5. **Top 3 this week**: the three highest-leverage actions, each with a deadline. Ask if they want them written into NOW.md.
6. Run `mkdir -p .brain-state && TZ=<timezone from brain.config.json> date +%F > .brain-state/weekly-review-last` so the weekly reminder stops.
