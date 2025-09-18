#!/bin/bash
NEW_TEMPLATE=$1

if [ -z "$NEW_TEMPLATE" ]; then
  echo "Usage: rotate-puzzle.sh <path-to-new-template>"
  exit 1
fi

rm -rf /puzzle-template/*
cp -r $NEW_TEMPLATE/* /puzzle-template/

echo "New puzzle template installed."
