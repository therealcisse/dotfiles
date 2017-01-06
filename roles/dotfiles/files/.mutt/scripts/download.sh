#!/bin/sh

if [ $# -ne 1 ]; then
  echo "error: expected exactly 1 argument, got $#."
  exit 1
fi

if [ $1 = "home" ]; then
  SYNC="Home-Download"
else
  echo "error: unrecognized account handle: $1."
  exit 1
fi

echo "Downloading $SYNC..."
mbsync "$SYNC"
