#!/bin/sh

get_st_popup_node_id() {
    echo "$(xdo id -N st-popup)"
}

create_st_popup() {
    st -c st-popup -e tmux new-session -A -s st-popup > /dev/null 2>&1 &

    sleep 0.200
}

exit

if [ -z "$(get_st_popup_node_id)" ]; then
    create_st_popup
fi

node_id="$(get_st_popup_node_id)"

if [ "$node_id" ]; then
    bspc node $node_id -g hidden --focus
    xdo move -x 0 -y 0 $node_id
fi
