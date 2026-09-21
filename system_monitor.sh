#!/bin/bash
# Master script: runs CPU, memory, and disk checks in sequence.
# Intended to be scheduled with cron.

cd "$(dirname "$0")" || exit 1

echo "----- Run started: $(date '+%Y-%m-%d %H:%M:%S') -----" >> logs/monitor.log

./cpu_monitor.sh
./memory_monitor.sh
./disk_monitor.sh

echo "----- Run finished -----" >> logs/monitor.log
