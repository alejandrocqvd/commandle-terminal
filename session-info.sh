#!/bin/bash
PLAYER_ID=$1
SESSION_DIR="/sessions/$PLAYER_ID"

if [ -z "$PLAYER_ID" ]; then
  echo "Usage: session-info.sh <player-id>"
  exit 1
fi

if [ ! -d "$SESSION_DIR" ]; then
  echo "No session found for $PLAYER_ID"
  exit 1
fi

echo "Session info for $PLAYER_ID:"
ls -lh $SESSION_DIR
ps -u $PLAYER_ID
