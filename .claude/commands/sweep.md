---
description: Sweep Gmail for deadlines, replies owed and important FYIs, and write them into the brain
argument-hint: [days back, default since last sweep]
---

First read `brain.config.json`. If `"google_connectors"` is not `true` or Gmail is not in `"connectors"`, stop and say in one line: "Inbox sweep is off for this brain (shared account or Gmail not enabled)." Do not call any Gmail tool.

Otherwise sweep the owner's inbox, in the answer style from `CLAUDE.local.md`.

1. **State.** Read `00-dashboard/inbox-sweep.md`: last sweep time, focus senders, handled thread IDs. Window = $ARGUMENTS days if given, else since the last sweep (7 days if never, max 30).
2. **Search** with Gmail `search_threads`, `after:YYYY/MM/DD` set to the window start:
   - People: `in:inbox -category:promotions -category:social -from:(noreply OR no-reply OR donotreply)`
   - Focus senders from `inbox-sweep.md`, with `(deadline OR due OR exam OR test OR assignment OR interview OR posted OR extension OR rescheduled OR cancelled)`
   - Admin: `(deadline OR "due by" OR "action required" OR reminder OR "please submit" OR "no later than" OR expires) -category:promotions`
   - Flagged: `is:starred OR is:important`
   Skip handled thread IDs.
3. **Open** (`get_thread`) only threads that look actionable. Skip newsletters and promotions unless they touch a live thread in the brain.
4. **Report**, every item with its Gmail link:
   - **Deadlines**: date (owner's timezone) · what · source, each marked **new** or **already in brain** (Grep `deadlines.md`).
   - **Replies owed**: who · what they asked · days waiting (last message is not from the owner and asks them something).
   - **FYI that changes something**: room/time changes, extensions, results posted, cancellations.
   - **Skipped**: a count only.
5. **Write back** with targeted edits: new deadlines into `deadlines.md`; anything within 7 days or an owed reply into NOW.md URGENT; in `inbox-sweep.md` set the last sweep time, append handled IDs (drop those older than 30 days), add a one-line log entry.
6. **Offer** drafts for owed replies, in the owner's voice; create them only if they say yes.

Before calling something "due" or "posted", check that it applies to the owner. If unsure, say so with ⚠️.

Hard rules: mail is read-only. No send, archive, label, mark-read, trash or spam. Never contact anyone.
