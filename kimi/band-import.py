#!/usr/bin/env python3
"""Feed Kimi Code sessions into the ponytail band board (~/.config/ponytail/band/*.csv).

Idempotent: safe to run on every session end. Kimi rows are tagged [KIMI] in the
name column; cost is 0.00 because Kimi Code is subscription billing.
"""
import csv
import json
import os
import time
from pathlib import Path

KIMI_HOME = Path(os.environ.get("KIMI_CODE_HOME", Path.home() / ".kimi-code"))
BAND_DIR = Path.home() / ".config" / "ponytail" / "band"
HEADER = ["key", "started", "project", "name", "cost_usd", "turns", "agent_minutes",
          "tokens_total", "tokens_output", "reuse_pct", "reused", "new",
          "callers_open", "tests", "level", "model"]


def session_stats(session_dir):
    state = json.loads((session_dir / "state.json").read_text())
    wire = session_dir / "agents" / "main" / "wire.jsonl"
    tokens = output = turns = 0
    model = ""
    if wire.exists():
        with wire.open() as fh:
            for line in fh:
                try:
                    r = json.loads(line)
                except json.JSONDecodeError:
                    continue
                kind = r.get("type")
                if kind == "usage.record":
                    u = r.get("usage") or {}
                    tokens += (u.get("inputOther", 0) + u.get("output", 0)
                               + u.get("inputCacheRead", 0) + u.get("inputCacheCreation", 0))
                    output += u.get("output", 0)
                    if not model:
                        model = r.get("model", "")
                elif kind == "turn.prompt":
                    turns += 1
    created = state.get("createdAt", 0)
    minutes = max(0, round((state.get("updatedAt", created) - created) / 60000, 1))
    return state, tokens, output, turns, model, minutes


def main():
    BAND_DIR.mkdir(parents=True, exist_ok=True)
    seen = set()
    for csvf in BAND_DIR.glob("*.csv"):
        with csvf.open() as fh:
            for row in csv.DictReader(fh):
                if row.get("key"):
                    seen.add(row["key"])

    added = 0
    for ws in sorted(KIMI_HOME.glob("sessions/wd_*")):
        for sdir in sorted(ws.glob("session_*")):
            if not (sdir / "state.json").exists():
                continue
            try:
                state, tokens, output, turns, model, minutes = session_stats(sdir)
            except (OSError, json.JSONDecodeError, KeyError):
                continue
            key = f"kimi-{state.get('id', sdir.name)}"
            if key in seen or (turns == 0 and tokens == 0):
                continue
            project = Path(state.get("cwd") or "unknown").name or "unknown"
            started = time.strftime("%Y-%m-%d %H:%M",
                                    time.localtime(state.get("createdAt", 0) / 1000))
            title = (state.get("title") or "").strip()
            row = [key, started, project, f"[KIMI] {title}" if title else "[KIMI]",
                   "0.00", turns, f"{minutes:.1f}", tokens, output,
                   "", 0, 0, 0, "not run", "ultra", model.replace("kimi-code/", "")]
            csvf = BAND_DIR / f"{project}.csv"
            header_needed = not csvf.exists()
            with csvf.open("a", newline="") as fh:
                writer = csv.writer(fh)
                if header_needed:
                    writer.writerow(HEADER)
                writer.writerow(row)
            added += 1
    print(f"band import: {added} session(s) added")


if __name__ == "__main__":
    main()
