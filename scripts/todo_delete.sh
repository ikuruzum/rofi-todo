#!/usr/bin/env bash
# todo_delete.sh: Handles the Rofi Delete mode. Deletes or adds tasks in ~/.todo.txt.

TODO_FILE="${HOME}/.todo.txt"

# Create the todo file if it doesn't exist
[ ! -f "$TODO_FILE" ] && touch "$TODO_FILE"
    echo -en "\0prompt\x1f󰆴 Delete\n"

# ROFI_RETV=0: Initial call, print the list (without prefix)
if [ -z "$ROFI_RETV" ] || [ "$ROFI_RETV" = "0" ]; then
    while IFS= read -r hrline; do
        [ -z "$hrline" ] && continue
        # If there are 4 characters at the start, print the rest
        # Remove the "[ ] " or "[x] " part to get the task text
        echo "$hrline" | cut -c5-
    done < "$TODO_FILE"
    exit 0
fi

# ROFI_RETV=1: User selected a task text, delete the relevant line
if [ "$ROFI_RETV" = "1" ]; then
    hrtask="$1"  # selected task text (e.g. "Buy groceries")
    # Delete the line containing this text (can be [ ] or [x])
    # - The matching line ^\[[ x]\] hrtask$ is deleted
    sed -i "/^\[[ x]\] $hrtask$/d" "$TODO_FILE"
    exit 0
fi

# ROFI_RETV=2: User entered new text, add it
if [ "$ROFI_RETV" = "2" ]; then
    hrnew="$1"
    if [ -n "$hrnew" ]; then
        echo "[ ] $hrnew" >> "$TODO_FILE"
    fi
    exit 0
fi
