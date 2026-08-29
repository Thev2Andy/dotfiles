#!/usr/bin/env bash
# Usage: ./move-window-to-workspace-silent.sh <Target>

if ! [[ -v 1 ]]; then
    echo -e "Invalid target workspace."
    exit 1
fi

TARGET=$1
CURRENT=$(niri msg -j workspaces | jq -r '.[] | select(.is_focused == true) | .idx')

niri msg action move-window-to-workspace ${TARGET}
niri msg action focus-workspace ${CURRENT}