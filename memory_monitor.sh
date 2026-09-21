#!/bin/bash
# Monitors memory usage and sends an email alert if it exceeds MEM_THRESHOLD

source ./config.env

MEM_USAGE=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')

echo "$(date '+%Y-%m-%d %H:%M:%S') Memory usage: ${MEM_USAGE}%" >> logs/monitor.log

if [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
    python3 send_email.py "Memory Alert: ${MEM_USAGE}%" \
        "Memory usage is at ${MEM_USAGE}%, which exceeds the threshold of ${MEM_THRESHOLD}%.

🚨 ALERT 🚨

Engineering team attention is requested.

Thank you."

    echo "$(date '+%Y-%m-%d %H:%M:%S') ALERT SENT - Memory at ${MEM_USAGE}%" >> logs/monitor.log
fi
