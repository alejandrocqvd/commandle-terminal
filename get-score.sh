#!/bin/bash
PLAYER_ID=$1
SESSION_DIR="/sessions/$PLAYER_ID"
SCORE_FILE="$SESSION_DIR/score.txt"

if [ -z "$PLAYER_ID" ]; then
  echo "Usage: get-score.sh <player-id>"
  exit 1
fi

if [ ! -d "$SESSION_DIR" ]; then
  echo "No session found for $PLAYER_ID"
  exit 1
fi

if [ ! -f "$SCORE_FILE" ]; then
  echo "0" > $SCORE_FILE
  chown root:root $SCORE_FILE
  chmod 644 $SCORE_FILE
fi

SCORE=$(cat $SCORE_FILE)
echo "$PLAYER_ID's score for this challenge: $SCORE"
