#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# todo_launcher.sh — Lets user choose between two submenus (Manage or Delete)
#    and runs the script of that mode within the same rofi session.
# -----------------------------------------------------------------------------

# 1) First rofi menu: only two lines ("Manage" and "Delete") are shown
#    When the user selects one, SELECTION gets that text.
rofi -modi "Manage:~/.config/waybar/scripts/todo_manage.sh,Delete:~/.config/waybar/scripts/todo_delete.sh" -show Manage
