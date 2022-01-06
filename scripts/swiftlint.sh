#!/bin/bash 

if test -d "/opt/homebrew/bin/"; then
  PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

ROOT_PATH=$1
SOURCES_PATH="Features/$2/Sources"

if which swiftlint >/dev/null; then
swiftlint --path $ROOT_PATH/$SOURCES_PATH --config $ROOT_PATH/.swiftlint.yml --quiet
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
