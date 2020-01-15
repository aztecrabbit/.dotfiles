#!/bin/dash

urxvtc -name popup -e tmux new-session \; split-window -v \; resize-pane -D 30 \; \
    select-pane -t 0 \; split-window -h \; select-pane -t 0 \; attach > /dev/null 2>&1
