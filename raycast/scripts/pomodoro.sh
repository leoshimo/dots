#!/usr/bin/env sh
# pomodoro.sh       -- Raycast frontend for Hammerspoon pomodoro

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pomodoro
# @raycast.mode silent
# @raycast.packageName Pomodoro

# Optional parameters:
# @raycast.argument1 { "type": "text", "placeholder": "action"}
# @raycast.argument2 { "type": "text", "placeholder": "duration", "optional": true }

ACTION="$1"
DURATION="$2"

# Find a matching prefix matching canonical action
function grepAction() {
    cat <<EOF | grep -e "^$1" | head -1
start
pause
resume
reset
EOF
}
ACTION=$(grepAction $ACTION)

if [ -z "$ACTION" ]; then
    echo "pomodoro: No action found"
    exit 1
fi

echo "pomodoro $ACTION"

HS_URL="hammerspoon://pomodoro?action=$ACTION"
if [ -n "$DURATION" ]; then
    HS_URL="$HS_URL&duration=$DURATION"
fi
open $HS_URL

