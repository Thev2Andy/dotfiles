#!/usr/bin/env bash
# Usage: ./launch-app.sh <Key>

# Config file locations
DEFAULT_CONFIG="$HOME/.config/niri/apps.default.json"
USER_CONFIG="$HOME/.config/niri/apps.override.json"

# Error message helper
report-failure() {
    notify-send "Launch Error" "Failed to launch application!\n${1}"
    echo -e "[Launch Error]\nFailed to launch application!\n${1}"
    exit 1
}

# Ensure we have a provided key
if ! [[ -v 1 ]]; then
    report-failure "No app key provided."
fi

TARGET="$1"
BIN=""

# Query JSON files for target binary
if [ -f "$USER_CONFIG" ] && [ -f "$DEFAULT_CONFIG" ]; then
    BIN=$(jq -s -r --arg key "$TARGET" '(.[0] * .[1])[$key] // empty' "$DEFAULT_CONFIG" "$USER_CONFIG")
elif [ -f "$USER_CONFIG" ]; then
    BIN=$(jq -r --arg key "$TARGET" '.[$key] // empty' "$USER_CONFIG")
elif [ -f "$DEFAULT_CONFIG" ]; then
    BIN=$(jq -r --arg key "$TARGET" '.[$key] // empty' "$DEFAULT_CONFIG")
else
    report-failure "Script Error: No configuration files exist."
fi

if [ -z "$BIN" ]; then
    report-failure "Unknown app key: $TARGET"
fi

# Execute queried target binary
eval "exec $BIN"