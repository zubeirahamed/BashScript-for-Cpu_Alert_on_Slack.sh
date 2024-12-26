#!/bin/bash

# Slack webhook URL
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"

# Threshold for CPU usage (in percentage)
THRESHOLD=10

# Get current CPU usage percentage
CPU_USAGE=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Check if CPU usage exceeds the threshold
if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    MESSAGE="High CPU usage detected: ${CPU_USAGE}%"
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$MESSAGE\"}" "$SLACK_WEBHOOK_URL"
fi
