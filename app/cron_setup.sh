#!/bin/bash

set -e

[ -z "$SUB_URL" ] || [ -z "$UPDATE_INTERVAL" ] || [ "$UPDATE_INTERVAL" -le 0 ] && { return 0 2>/dev/null || exit 0; }

CRON_FILE="/etc/cron.d/mihomo-update"
CRON_SCHEDULE="0 */$UPDATE_INTERVAL * * *"

echo "$CRON_SCHEDULE bash /app/config_update.sh cron >> /var/log/cron.log 2>&1" > "$CRON_FILE"
chmod 0644 "$CRON_FILE"
crontab "$CRON_FILE"

cron || crond || true
