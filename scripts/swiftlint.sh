#!/bin/bash 

if test -d "/opt/homebrew/bin/"; then
  PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

SOURCES_PATH="Features/$1/Sources"

if which swiftlint >/dev/null; then
swiftlint --path $SOURCES_PATH --config .swiftlint.yml --quiet
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
