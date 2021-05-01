#!/bin/bash 

SOURCES_PATH="Targets/Pokedex/Sources"

if which swiftlint >/dev/null; then
swiftlint --path $SOURCES_PATH --config ../.swiftlint.yml --quiet
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi

