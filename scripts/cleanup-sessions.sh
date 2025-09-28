#!/bin/bash
# Unified session manager: kicks idle players and cleans up abandoned sessions
# Configure timeouts here:
IDLE_LIMIT=15     # minutes: how long before a player is kicked if idle
ORPHAN_LIMIT=60   # minutes: how long before an abandoned folder is deleted

echo "Running unified session management..."

# --- 1. Kick idle players (based on process age) ---
for player in $(ls /sessions 2>/dev/null); do
  PID=$(pgrep -u $player bash | head -n 1)
  if [ -n "$PID" ]; then
    ELAPSED=$(ps -o etimes= -p $PID | tail -n 1)  # in seconds
    LIMIT=$((IDLE_LIMIT * 60))

    if [ "$ELAPSED" -gt "$LIMIT" ]; then
      echo "Kicking $player (idle $((ELAPSED/60)) min)"
      pkill -u $player
      userdel -r $player 2>/dev/null
      rm -rf /sessions/$player
    fi
  fi
done

# --- 2. Cleanup orphaned sessions (no active process) ---
find /sessions -mindepth 1 -maxdepth 1 -type d -mmin +$ORPHAN_LIMIT | while read dir; do
  player=$(basename "$dir")
  if ! pgrep -u $player >/dev/null 2>&1; then
    echo "Removing orphaned session: $player (folder > $ORPHAN_LIMIT min old, no process)"
    userdel -r $player 2>/dev/null
    rm -rf "$dir"
  fi
done

echo "Session management complete."
