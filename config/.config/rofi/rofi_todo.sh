#!/usr/bin/env bash

# CONFIGURATION
# -----------------------------------------------------------------------------
TODO_FILE="$HOME/.config/rofi/todos.md"
WORKING_FILE="$HOME/.config/rofi/working_on.txt"
mkdir -p "$(dirname "$TODO_FILE")"
touch "$TODO_FILE" "$WORKING_FILE"

# SED command for macOS/Linux
SED_COMMAND="sed -i"
if [[ "$(uname)" == "Darwin" ]]; then
	SED_COMMAND="sed -i ''"
fi

# ICONS (Nerd Font)
# -----------------------------------------------------------------------------
ICON_TODO="󰄱"    # checkbox_blank_outline
ICON_DONE="󰄲"    # checkbox_marked
ICON_ADD=""     # plus_circle
ICON_DEL=""     # trash
ICON_WORKING="󰓎" # fire
ICON_SEP="✔"     # check

# FORMAT FUNCTION (MODIFIED)
# -----------------------------------------------------------------------------
format_todos() {
	local todo_items=""
	local done_items=""

	# Read the file once and prepare formatted strings for both lists
	while IFS= read -r line; do
		NUMBER=$(echo "$line" | cut -d'|' -f1)
		CONTENT=$(echo "$line" | cut -d'|' -f2-)
		TEXT=$(echo "$CONTENT" | sed 's/- \[[x ]\] //')
		IS_DONE=$(echo "$CONTENT" | grep -q "\[x\]" && echo "yes" || echo "no")

		if grep -Fxq "$NUMBER" "$WORKING_FILE"; then
			WORKING_MARK="<span color='red'>${ICON_WORKING}</span> "
		else
			WORKING_MARK=""
		fi

		if [[ "$IS_DONE" == "yes" ]]; then
			# Append formatted 'done' item to its variable
			done_items+="$NUMBER|  $WORKING_MARK<span color='green'>${ICON_DONE}  </span> <span alpha='80%'><s>$TEXT</s></span>\n"
		else
			# Append formatted 'todo' item to its variable
			todo_items+="$NUMBER|  $WORKING_MARK<span color='orange'>${ICON_TODO}  </span> $TEXT\n"
		fi
	done < <(nl -w1 -s'|' "$TODO_FILE")

	# Print active todos first
	echo -en "$todo_items"

	# If there are both active and done tasks, print a separator
	if [[ -n "$todo_items" && -n "$done_items" ]]; then
		# This is a non-selectable separator for Rofi
		# The '0|' prefix prevents errors if it's somehow selected.
		echo "<b>───────────────────────────── <span color='green'>${ICON_SEP}</span> DONE ─────────────────────────────────</b>"
	fi

	# Print completed todos last
	echo -en "$done_items"
}

# MAIN LOOP
# -----------------------------------------------------------------------------
while true; do
	SELECTION=$(format_todos | rofi -theme ~/.config/rofi/themes/todo-large.rasi -dmenu -p "Todo" \
		-mesg "<b>Alt+a:</b> ${ICON_ADD} Add  |  <b>Alt+d:</b> ${ICON_DEL} Delete  |  <b>Alt+w:</b> ${ICON_WORKING} Working on  |  <b>Enter:</b> Toggle Done" \
		-markup-rows \
		-i \
		-kb-custom-1 "Alt+a" \
		-kb-custom-2 "Alt+d" \
		-kb-custom-3 "Alt+w" \
		-format 's')

	EXIT_CODE=$?

	LINE_NUMBER=$(echo "$SELECTION" | cut -d'|' -f1)

	# Ignore the separator line
	if [[ "$LINE_NUMBER" == "0" ]]; then
		continue
	fi

	LINE_CONTENT=$(sed "${LINE_NUMBER}q;d" "$TODO_FILE")

	case $EXIT_CODE in
	0) # Toggle done
		if [ -z "$LINE_NUMBER" ]; then continue; fi
		if [[ "$LINE_CONTENT" == *"- [ ]"* ]]; then
			${SED_COMMAND} "${LINE_NUMBER}s/\[ \]/[x]/" "$TODO_FILE"
			# Remove from working if it was marked
			sed -i "/^$LINE_NUMBER$/d" "$WORKING_FILE"
		elif [[ "$LINE_CONTENT" == *"- [x]"* ]]; then
			${SED_COMMAND} "${LINE_NUMBER}s/\[x\]/[ ]/" "$TODO_FILE"
		fi
		;;
	10) # Add
		NEW_TODO=$(rofi -theme ~/.config/rofi/themes/todo-large.rasi -dmenu -p "${ICON_ADD}    Add new todo")
		if [ -n "$NEW_TODO" ]; then
			echo "- [ ] $NEW_TODO" >>"$TODO_FILE"
		fi
		;;
	11) # Delete
		if [ -z "$LINE_NUMBER" ]; then continue; fi
		${SED_COMMAND} "${LINE_NUMBER}d" "$TODO_FILE"
		sed -i "/^$LINE_NUMBER$/d" "$WORKING_FILE"
		;;
	12) # Toggle Working On
		if [ -z "$LINE_NUMBER" ]; then continue; fi
		if grep -Fxq "$LINE_NUMBER" "$WORKING_FILE"; then
			sed -i "/^$LINE_NUMBER$/d" "$WORKING_FILE"
		else
			echo "$LINE_NUMBER" >>"$WORKING_FILE"
		fi
		;;
	1 | *) # Escape
		exit 0
		;;
	esac
done
