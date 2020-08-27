#!/bin/bash

create_st_popup() {
    st='st -c st-popup -e'

	$st tmux new-session -A -s st-popup > /dev/null 2>&1 &

	# $st tmux new -s st-popup \; split-window -v \; select-pane -t 1 \; \
    #     split-window -h \; select-pane -t 1 \; resize-pane -D 24 \; attach > /dev/null 2>&1 &
}

main() {
    node_id=$(xdo id -N st-popup)

    if [[ -z $node_id ]]; then
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
