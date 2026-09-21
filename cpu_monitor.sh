#!/bin/bash
# Monitors CPU usage and sends an email alert if it exceeds CPU_THRESHOLD

source ./config.env

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)

echo "$(date '+%Y-%m-%d %H:%M:%S') CPU usage: ${CPU_USAGE}%" >> logs/monitor.log

if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
    python3 send_email.py "CPU Alert: ${CPU_USAGE}%" \
        "CPU usage is at ${CPU_USAGE}%, which exceeds the threshold of ${CPU_THRESHOLD}%.

🚨 ALERT 🚨

Engineering team attention is requested.

Thank you."

    echo "$(date '+%Y-%m-%d %H:%M:%S') ALERT SENT - CPU at ${CPU_USAGE}%" >> logs/monitor.log
fi

