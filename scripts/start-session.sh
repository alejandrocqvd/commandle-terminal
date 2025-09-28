#!/bin/bash
PLAYER_ID=$1
SESSION_DIR="/sessions/$PLAYER_ID"

if [ -z "$PLAYER_ID" ]; then
  echo "Usage: start-session.sh <player-id>"
  exit 1
fi

# Create user if not exists
id -u "$PLAYER_ID" &>/dev/null || useradd -M -d "$SESSION_DIR" "$PLAYER_ID"

# Create session dir if not exists
if [ ! -d "$SESSION_DIR" ]; then
  mkdir -p "$SESSION_DIR"
  cp -r /puzzle-template/* "$SESSION_DIR/"
  chown -R "$PLAYER_ID:$PLAYER_ID" "$SESSION_DIR"
  chmod 700 "$SESSION_DIR"
  echo "0" > "$SESSION_DIR/score.txt"
  chown root:root "$SESSION_DIR/score.txt"
  chmod 644 "$SESSION_DIR/score.txt"
fi

echo "Session created for $PLAYER_ID in $SESSION_DIR"
