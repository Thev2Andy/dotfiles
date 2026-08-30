#!/usr/bin/env bash
# Usage: ./launch-app.sh <Key>

# App override config
CONFIG="$HOME/.config/niri/apps.json"
if ! [ -f "$CONFIG" ]; then
    echo -e "WARN: No apps.json config file found."
fi

# Ensure we have a provided key
if ! [[ -v 1 ]]; then
    echo -e "No app key provided."
    exit 1
fi

# Defaults
DEFAULT_TERMINAL="kitty"
DEFAULT_FILES="nautilus --new-window"
DEFAULT_BROWSER="firefox"
DEFAULT_EDITOR="code"
DEFAULT_IPC_INSTANT_REPLAY="obs-cmd replay save"

# Query JSON file for binary
get_app() {
    local APP_KEY="$1"
    if [ -f "$CONFIG" ]; then
        jq -r --arg key "$APP_KEY" '.[$key] // empty' "$CONFIG"
    fi
}

TARGET="$1"
BIN=$(get_app "$TARGET")

# Fall back to defaults if not found in JSON
if [ -z "$BIN" ]; then
    case "$TARGET" in
        terminal) BIN="$DEFAULT_TERMINAL" ;;
        files) BIN="$DEFAULT_FILES" ;;
        browser) BIN="$DEFAULT_BROWSER" ;;
        editor) BIN="$DEFAULT_EDITOR" ;;
        ipc-instant-replay) BIN="$DEFAULT_IPC_INSTANT_REPLAY" ;;
        *) echo "ERROR: Unknown app: $TARGET" >&2; exit 1 ;;
    esac
fi

exec $BIN