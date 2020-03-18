#!/bin/sh

st -c st-popup -e tmux new-session \; split-window -v \; select-pane -t 1 \; \
    split-window -h \; select-pane -t 1 \; resize-pane -D 24 \; attach > /dev/null 2>&1

