#!/bin/bash

interval=1
interface="enp0s29f7u7"

declare -A bytes

bytes[past_rx_lo]=0
bytes[past_tx_lo]=0
bytes[past_rx_$interface]=0
bytes[past_tx_$interface]=0

is_interface_active()
{
    if [[ ! -f "/sys/class/net/$interface/statistics/rx_bytes" ]]; then
        return 0
    fi

    return 1
}

print_bytes()
{
    if [ "$1" -le 0 ]; then
        bytes="0.000 KB/s"
    elif [ "$1" -lt 1024 ]; then
        bytes="$(echo "scale=3;$1/1024" | bc -l | awk '{printf "%.3f\n", $0}') KB/s"
    elif [ "$1" -lt 1048576 ]; then
        bytes="$(echo "scale=3;$1/1024" | bc -l) KB/s"
    else
        bytes="$(echo "scale=3;$1/1048576" | bc -l) MB/s"
    fi

    echo "$bytes"
}

print_total()
{
    total=$(((( $1 + $2 ))))

    if [ "$1" -le 0 ]; then
        bytes="0.000 KB"
    elif [ "$1" -lt 1024 ]; then
        bytes="$(echo "scale=3;$1/1024" | bc -l | awk '{printf "%.3f\n", $0}') KB"
    elif [ "$1" -lt 1048576 ]; then
        bytes="$(echo "scale=3;$1/1024" | bc -l) KB"
    elif [ "$1" -lt 1073741824 ]; then
        bytes="$(echo "scale=3;$1/1048576" | bc -l) MB"
    else
        bytes="$(echo "scale=3;$1/1073741824" | bc -l) GB"
    fi

    echo "$bytes"
}

while true; do
    active=0 && is_interface_active || active=1

    down=0
    up=0

    bytes[now_rx_lo]="$(cat /sys/class/net/lo/statistics/rx_bytes)"
    bytes[now_tx_lo]="$(cat /sys/class/net/lo/statistics/tx_bytes)"

    total_lo="$(print_total ${bytes[now_rx_lo]} ${bytes[now_tx_lo]})"

    if [[ $active -eq 1 ]]; then
        if [[ ${bytes[past_rx_$interface]} -eq 0 ]] || [[ ${bytes[past_tx_$interface]} -eq 0 ]]; then
            bytes[past_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
            bytes[past_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"
        fi

        bytes[now_rx_$interface]="$(cat /sys/class/net/"$interface"/statistics/rx_bytes)"
        bytes[now_tx_$interface]="$(cat /sys/class/net/"$interface"/statistics/tx_bytes)"

        bytes_down=$((((${bytes[now_rx_$interface]} - ${bytes[past_rx_$interface]})) / interval))
        bytes_up=$((((${bytes[now_tx_$interface]} - ${bytes[past_tx_$interface]})) / interval))

        bytes[past_rx_$interface]=${bytes[now_rx_$interface]}
        bytes[past_tx_$interface]=${bytes[now_tx_$interface]}

        down=$(((( "$down" + "$bytes_down" ))))
        up=$(((( "$up" + "$bytes_up" ))))

        echo "$(print_bytes $down)  $(print_bytes $up)  $(print_total ${bytes[now_rx_$interface]} ${bytes[now_tx_$interface]})  -  $total_lo"
    else
        echo "$total_lo"
    fi

    sleep $interval
done
