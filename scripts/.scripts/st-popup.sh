#!/bin/bash

create_st_popup() {
    st="st -c st-popup -e"

    tmux attach -t st-popup

    if [[ $? -eq 1 ]]; then
        $st tmux attach -t st-popup > /dev/null 2>&1 &
    else
        $st tmux new -s st-popup \; split-window -v \; select-pane -t 1 \; \
            split-window -h \; select-pane -t 1 \; resize-pane -D 24 \; attach > /dev/null 2>&1 &
    fi
}

main() {
    node_id=$(xdo id -N st-popup)

    if [[ ! $node_id ]]; then
        create_st_popup

        sleep 0.200

        node_id=$(xdo id -N st-popup)
    fi

    if [[ $node_id ]]; then
        bspc node $node_id -g hidden --focus
        xdo move -x 0 -y 0 $node_id
    fi
}

main
