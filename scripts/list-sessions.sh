#!/bin/bash
echo "Active sessions:"
for d in /sessions/*/ ; do
  [ -d "$d" ] || continue
  player=$(basename "$d")
  echo "- $player"
done
