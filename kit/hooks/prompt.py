#!/usr/bin/env python3
"""UserPromptSubmit hook: setup nudge, live time, birthday and weekly-review reminders.

Everything is driven by brain.config.json. Prints nothing it was not asked to print.
"""
import datetime as dt
import json
import os
import pathlib
import re
import sys
from zoneinfo import ZoneInfo

ROOT = pathlib.Path(os.environ.get("CLAUDE_PROJECT_DIR") or pathlib.Path(__file__).resolve().parents[2])
CONFIG = ROOT / "brain.config.json"
STATE = ROOT / ".brain-state"

try:
    session = json.load(sys.stdin).get("session_id", "nosession")
except Exception:
    session = "nosession"

if not CONFIG.exists():
    print("SETUP NEEDED: this second brain has not been set up (no brain.config.json). "
          "Before answering, tell the user in one line and start the interview in kit/SETUP.md.")
    sys.exit(0)

try:
    cfg = json.loads(CONFIG.read_text())
except Exception as e:
    print(f"brain.config.json is unreadable ({e}). Tell the user and offer to fix it.")
    sys.exit(0)

hooks = cfg.get("hooks", {})
owner = cfg.get("owner_name", "the owner")
tz = ZoneInfo(cfg.get("timezone", "UTC"))
second = cfg.get("second_timezone")  # {"label": "...", "tz": "..."} or null
now = dt.datetime.now(tz)
today = now.date()


def once(name):
    """True the first time this reminder fires in this session today."""
    if session == "nosession":
        return True
    STATE.mkdir(exist_ok=True)
    stamp = STATE / f"{name}-{session}-{today}"
    if stamp.exists():
        return False
    stamp.touch()
    cutoff = dt.datetime.now().timestamp() - 7 * 86400
    for old in STATE.glob("*-*-*"):
        if old.is_file() and old.stat().st_mtime < cutoff and old.name != "weekly-review-last":
            old.unlink()
    return True


if hooks.get("time", True):
    line = f"Current time: {now:%a %d %b %Y, %H:%M} {cfg.get('timezone_label') or now.tzname()}"
    if second:
        other = dt.datetime.now(ZoneInfo(second["tz"]))
        line += f" | {other:%a %d %b %H:%M} {second.get('label') or other.tzname()}"
    print(line)

if hooks.get("birthdays"):
    path = ROOT / cfg.get("birthdays_file", "01-profile/birthdays.md")
    births = {}
    if path.exists():
        for raw in path.read_text().splitlines():
            m = re.match(r"- (\d\d-\d\d) (.+)", raw.strip())
            if m:
                births.setdefault(m.group(1), []).append(m.group(2).strip())
    key = lambda d: d.strftime("%m-%d")
    on_today = births.get(key(today), [])
    tomorrow = births.get(key(today + dt.timedelta(days=1)), [])
    if (on_today or tomorrow) and once("birthday"):
        parts = []
        if on_today:
            parts.append(f"TODAY is the birthday of: {', '.join(on_today)}.")
        if tomorrow:
            parts.append(f"TOMORROW is the birthday of: {', '.join(tomorrow)}.")
        print("BIRTHDAY REMINDER: " + " ".join(parts) +
              f" At the top of your reply, prompt {owner} to wish them happy birthday "
              "(or to plan to tomorrow), then answer the message.")

if hooks.get("weekly_review"):
    day = int(cfg.get("weekly_review_day", 6))  # Monday=0 ... Sunday=6
    start = today - dt.timedelta(days=(today.weekday() - day) % 7)
    try:
        last = dt.date.fromisoformat((STATE / "weekly-review-last").read_text().strip())
    except Exception:
        last = dt.date.min
    if last < start and once("weekly"):
        print(f"WEEKLY REVIEW due (none done since {start:%a %d %b}). Offer it in one line at the top "
              "of your reply: they run /weekly-review. Then answer the message.")
