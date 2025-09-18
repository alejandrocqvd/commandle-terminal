#!/bin/bash
PLAYER_ID=$1
SESSION_DIR="/sessions/$PLAYER_ID"

if [ -z "$PLAYER_ID" ]; then
  echo "Usage: start-session.sh <player-id>"
  exit 1
fi

id -u $PLAYER_ID &>/dev/null || useradd -m -d $SESSION_DIR $PLAYER_ID

if [ ! -d "$SESSION_DIR" ]; then
  cp -r /puzzle-template/* $SESSION_DIR/
  chown -R $PLAYER_ID:$PLAYER_ID $SESSION_DIR
  chmod 700 $SESSION_DIR
  echo "0" > $SESSION_DIR/score.txt
  chown root:root $SESSION_DIR/score.txt
  chmod 644 $SESSION_DIR/score.txt
fi

exec su - $PLAYER_ID
