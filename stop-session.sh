#!/bin/bash
PLAYER_ID=$1
SESSION_DIR="/sessions/$PLAYER_ID"

if [ -z "$PLAYER_ID" ]; then
  echo "Usage: stop-session.sh <player-id>"
  exit 1
fi

pkill -u $PLAYER_ID
userdel -r $PLAYER_ID 2>/dev/null
rm -rf $SESSION_DIR

echo "Session for $PLAYER_ID stopped and cleaned up."
