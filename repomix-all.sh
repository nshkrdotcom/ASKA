#!/usr/bin/env bash
set -euo pipefail

root="$PWD"
mkdir -p "$root/tmp"

npx --yes repomix . --output "$root/tmp/repomix-root.xml" --ignore 'tmp/**'

for directory in "$root"/v*/; do
  [[ -d "$directory" ]] || continue
  name="$(basename "$directory")"
  (
    cd "$directory"
    npx --yes repomix . --output "$root/tmp/repomix-$name.xml"
  )
done
