#!/bin/bash

# ###
# ### This script will check the disk usage of the root partition.
# ### @Author: Elad Chadad
# ### 

# Set threshold
THRESHOLD=85

# Get the usage percentage of the root (/) partition without %
USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

# Log file location
LOGFILE="/var/log/disk_usage_alert.log"

# Check if usage is greater than threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "$(date): WARNING - Root filesystem usage is at ${USAGE}%." >> "$LOGFILE"
fi
