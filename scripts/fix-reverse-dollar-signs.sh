#! /bin/sh

set -e

if [[ `uname -s` != "Darwin" ]]; then
  echo "Only supported on OS X"
  exit 1
fi

find Wikipedia/Localizations -iname '*.strings' -print | xargs -L 1 sed -E -i '' 's:\%([1-9]+)\$:$\1:g;s:([1-9]+)\$:$\1:g;s:\%([1-9]+):$\1:g'