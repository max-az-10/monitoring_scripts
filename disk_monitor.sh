#!/bin/bash
# Monitors disk usage on / and sends an email alert if it exceeds DISK_THRESHOLD

source ./config.env

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "$(date '+%Y-%m-%d %H:%M:%S') Disk usage: ${DISK_USAGE}%" >> logs/monitor.log

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    python3 send_email.py "Disk Alert: ${DISK_USAGE}%" \
        "Disk usage is at ${DISK_USAGE}%, which exceeds the threshold of ${DISK_THRESHOLD}%.

🚨 ALERT 🚨

Engineering team attention is requested.

Thank you."

    echo "$(date '+%Y-%m-%d %H:%M:%S') ALERT SENT - Disk at ${DISK_USAGE}%" >> logs/monitor.log
fi
