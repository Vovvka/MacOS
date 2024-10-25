#!/bin/bash

output_file="$HOME/Desktop/battery_log.txt"

logged_100=false
logged_2=false
time_start=""
time_end=""

# Disable power-saving features
pmset -a sleep 0 displaysleep 0 disksleep 0 autopoweroff 0 standby 0

# Function to start CPU load
start_load() {
    for i in {1..7}; do
        yes > /dev/null &
    done
}

# Start CPU load
start_load

# Monitor battery levels
while true; do
    # Get the current battery level
    battery_level=$(pmset -g batt | grep -o '[0-9]\+%' | tr -d '%')

    # Log when battery reaches 100%
    if [ "$battery_level" -eq 100 ] && [ "$logged_100" = false ]; then
        time_start=$(date +%s)
        echo "Battery level reached 100% at $(date "+%Y-%m-%d %H:%M:%S")" >> "$output_file"
        logged_100=true
    fi

    # Log when battery reaches 5%
    if [ "$battery_level" -le 5 ] && [ "$logged_2" = false ]; then
        time_end=$(date +%s)
        echo "Battery level reached 5% at $(date "+%Y-%m-%d %H:%M:%S")" >> "$output_file"
        
        # Calculate time taken to drop from 100% to 2%
        time_diff=$((time_end - time_start))
        hours=$((time_diff / 3600))
        minutes=$(( (time_diff % 3600) / 60 ))
        seconds=$((time_diff % 60))
        echo "Time taken for battery to drop from 100% to 2%: ${hours}h ${minutes}m ${seconds}s" >> "$output_file"

        # Stop load processes and forget Wi-Fi after logging
        killall yes

        sudo networksetup -removepreferredwirelessnetwork en0 CORP_net && sudo networksetup -setairportpower en0 off

        # Restore default power settings
        sudo pmset -a sleep 10 displaysleep 10 disksleep 10 autopoweroff 1 standby 1

        exit 0
    fi

    # Sleep for 30 seconds before the next check
    sleep 30
done
