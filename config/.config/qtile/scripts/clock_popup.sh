#!/bin/bash

# -----------------------------------------------------------------------------
# CONFIGURATION
# -----------------------------------------------------------------------------
TODO_FILE="$HOME/.config/rofi/Todo_files/todos.md"
mkdir -p "$(dirname "$TODO_FILE")"
touch "$TODO_FILE"

# -----------------------------------------------------------------------------
# DATE & HEADER SETUP
# -----------------------------------------------------------------------------
today=$(date "+%Y-%m-%d")
header=$(date "+%A, %d %B %Y")

# -----------------------------------------------------------------------------
# PROCESSING FUNCTIONS
# -----------------------------------------------------------------------------

# Assign priorities and format task lines
process_tasks() {
	# $1 should be "done" or "undone"
	mode="$1"
	awk -v mode="$mode" '
    {
        prio = 2;
        line = $0;
        raw_line = $0;

        # Extract and remove @Color(...) tag
        color = "";
        if (match(line, /@Color\([^)]+\)/)) {
            color_tag = substr(line, RSTART, RLENGTH);
            sub(/@Color\([^)]+\)/, "", line);
            color_name = color_tag;
            gsub(/@Color\(|\)/, "", color_name);
            gsub(/[ \t]+$/, "", color_name);  # Remove trailing spaces
            color = color_name;
        }

        # Replace priority tags
        if (sub(/@Prio\(high\)/, "(High)", line)) {
            prio = 1;
        } else if (sub(/@Prio\(low\)/, "(Low)", line)) {
            prio = 3;
        } else if (sub(/@Prio\(normal\)/, "(Normal)", line)) {
            prio = 2;
        }

        # Remove markdown checkboxes and date
        sub(/- \[.?\] */, "", line);
        sub(/ *@([0-9]{4}(-[0-9]{2}){2}).*/, "", line);
        gsub(/^[ \t]+|[ \t]+$/, "", line);  # trim

        # Add checkbox symbol based on mode
        box = (mode == "done") ? "- [ x ]  " : "- [  ]  ";
        final_line = box line;

        # Apply color if specified
        if (color != "") {
            final_line = "<span foreground=\"" color "\">" final_line "</span>";
        }

        print prio "|" final_line;
    }' |
		sort -n |
		cut -d'|' -f2-
}

# Highlight priority labels with color
highlight_priority() {
	sed -e 's/(High)/<span foreground="#FF6B6B">(High)<\/span>/g' \
		-e 's/(Low)/<span foreground="#FFD580">(Low)<\/span>/g' \
		-e 's/(Normal)/<span foreground="#ffffff">(Normal)<\/span>/g'
}

# -----------------------------------------------------------------------------
# GATHER & PROCESS TASKS
# -----------------------------------------------------------------------------

# 1. Due today
due_today=$(grep "\[ \].*@${today}" "$TODO_FILE" | process_tasks "undone" | highlight_priority)

# 2. Done today
done_today=$(grep "\[x\].*@${today}" "$TODO_FILE" | process_tasks "done" | highlight_priority)

# 3. General (past-due)
general=$(
	awk -v d="$today" '
        /- \[ \] .*@([0-9]{4}-[0-9]{2}-[0-9]{2})/ {
            match($0, /@([0-9]{4}-[0-9]{2}-[0-9]{2})/, a);
            if (a[1] < d) print $0;
        }
    ' "$TODO_FILE" | process_tasks | shuf | head -n 4 | highlight_priority
)

# 4. Future tasks
future=$(
	awk -v d="$today" '
        /- \[ \] .*@([0-9]{4}-[0-9]{2}-[0-9]{2})/ {
            match($0, /@([0-9]{4}-[0-9]{2}-[0-9]{2})/, a);
            if (a[1] > d) print $0;
        }
    ' "$TODO_FILE" | process_tasks | shuf | head -n 4 | highlight_priority
)

# -----------------------------------------------------------------------------
# FALLBACKS
# -----------------------------------------------------------------------------

[ -z "$due_today" ] && due_today="<i>(No tasks for today)</i>"
[ -z "$done_today" ] && done_today="<i>(No tasks completed today)</i>"
[ -z "$general" ] && general="<i>(No general tasks)</i>"
[ -z "$future" ] && future="<i>(No future tasks)</i>"

# -----------------------------------------------------------------------------
# DISPLAY NOTIFICATION
# -----------------------------------------------------------------------------
# <b><span foreground='#ffffff'>📝 General (Past Due):</span></b><br>$general

notify-send -u low -h string:markup:1 -t 20000 \
	"what is the plan Today?" \
	"<b><span foreground='#ffffff'>$header</span></b>
<b><span >-----------------------------------------------------------------------</span></b>
<b><span foreground='#ffffff'>🗓️ Due Today:</span></b>
<b><span >$due_today</span></b>
<b><span >-----------------------------------------------------------------------</span></b>
<b><span foreground='#c678dd'>✅ Done Today:</span></b>
<b><span foreground='#70D78F'>$done_today</span></b>
<b><span >-----------------------------------------------------------------------</span></b>
<b><span >📝 General (Past Due):</span></b>
<b><span foreground='#ffffff' >$general</span></b>
<b><span >-----------------------------------------------------------------------</span></b>
<b><span >⏳ Future Tasks:</span></b>
<b><span foreground='#ffffff' >$future</span></b>"
