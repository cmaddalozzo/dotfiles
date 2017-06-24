#!/bin/sh
if [ -z "$1" ]
then
  echo "Usage: ./link.sh <dotfile> [target]"
  exit 1
fi
SOURCE="$1"
TARGET="${2:-$HOME/$SOURCE}"
if [ -L "$TARGET" ]
then
  echo "Target link exists"
  exit 1
fi
if [ -f "$TARGET" ]
then
  echo "Moving existing target to $TARGET.bak"
  mv $TARGET "$TARGET.bak"
fi
ln -s "$PWD/$SOURCE" $TARGET
echo "$TARGET -> $SOURCE"
