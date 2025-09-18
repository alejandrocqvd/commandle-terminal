#!/bin/bash
IDLE_LIMIT=15 # minutes

echo "Checking for idle players > $IDLE_LIMIT minutes..."

for player in $(ls /sessions); do
  PID=$(pgrep -u $player bash | head -n 1)
  if [ -n "$PID" ]; then
    ELAPSED=$(ps -o etimes= -p $PID) # seconds
    LIMIT=$((IDLE_LIMIT * 60))
    if [ "$ELAPSED" -gt "$LIMIT" ]; then
      echo "Kicking $player (idle $ELAPSED s)"
      pkill -u $player
      userdel -r $player 2>/dev/null
      rm -rf /sessions/$player
    fi
  fi
done
