#!/usr/bin/env bash
# Usage: ./maximize-window-or-column.sh

# Fetch all windows in JSON format.
WINDOWS=$(niri msg --json windows)

# Evaluate focused window layout.
RESULT=$(echo "$WINDOWS" | jq -r '
  (.[] | select(.is_focused)) as $focused |
  if ($focused == null) then
    "no_focus"
  elif $focused.is_floating then
    "floating"
  else
    $focused.workspace_id as $ws |
    $focused.layout.pos_in_scrolling_layout[0] as $col |
    
    # Count non-floating windows in the exact same workspace and column
    ([.[] | select(.workspace_id == $ws and .is_floating == false and .layout.pos_in_scrolling_layout[0] == $col)] | length) as $count |

    if $count == 1 then
      "solo_in_column"
    else
      "stacked_in_column (\($count) windows)"
    end
  end
')

# Maximize the window if floating or stacked, maximize the column if the window is alone in the column
case "$RESULT" in
    "solo_in_column")
        niri msg action maximize-column
        ;;
    stacked_in_column*)
        niri msg action consume-or-expel-window-right
        niri msg action maximize-column
        ;;
    "floating")
        niri msg action maximize-window-to-edges
        ;;
    *)
        echo "No active window."
        ;;
esac