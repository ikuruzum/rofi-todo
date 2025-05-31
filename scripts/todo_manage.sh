#!/usr/bin/env bash
# todo_manage.sh: Handles the Rofi Manage mode. Manages the ~/.todo.txt file.

TODO_FILE="${HOME}/.todo.txt"

# Create the todo file if it doesn't exist
[ ! -f "$TODO_FILE" ] && touch "$TODO_FILE"
    echo -en "\0prompt\x1f Manage\n"
# ROFI_RETV=0 (or empty) means initial call: print the list
# Rofi, giriş listesine satırları ekler
if [ -z "$ROFI_RETV" ] || [ "$ROFI_RETV" = "0" ]; then
    # Print each line as-is
    while IFS= read -r hrline; do
        [ -z "$hrline" ] && continue   # Skip empty lines
        echo "$hrline"
    done < "$TODO_FILE"
    exit 0
fi

# ROFI_RETV=1 means user has selected an existing item
if [ "$ROFI_RETV" = "1" ]; then
    hrchoice="$1"   # selected line, e.g. "[ ] Buy groceries"
    # Toggle the line based on its prefix
    if printf '%s\n' "$hrchoice" | grep -q '^\[ \] '; then
        # If it starts with "[ ] ", mark it as done
        hrtask=$(printf '%s\n' "$hrchoice" | cut -c5-)
        sed -i "s/^\[ \] $hrtask$/[x] $hrtask/" "$TODO_FILE"
    elif printf '%s\n' "$hrchoice" | grep -q '^\[x\] '; then
        # If it starts with "[x] ", unmark it
        hrtask=$(printf '%s\n' "$hrchoice" | cut -c5-)
        sed -i "s/^\[x\] $hrtask$/[ ] $hrtask/" "$TODO_FILE"
    fi
    exit 0
fi

# ROFI_RETV=2 means user has entered and confirmed new text
if [ "$ROFI_RETV" = "2" ]; then
    hrnew="$1"  # user-entered new text
    # If the text is not empty, prepend "[ ] " and append to the file
    if [ -n "$hrnew" ]; then
        echo "[ ] $hrnew" >> "$TODO_FILE"
    fi
    exit 0
fi