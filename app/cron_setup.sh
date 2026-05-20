#!/bin/bash

set -e

[ -z "$SUB_URL" ] || [ -z "$UPDATE_INTERVAL" ] || [ "$UPDATE_INTERVAL" -le 0 ] && { return 0 2>/dev/null || exit 0; }

CRON_DIR="/var/spool/cron/crontabs"
CRON_FILE="$CRON_DIR/root"

[ ! -f "$CRON_FILE" ] && mkdir -p "$CRON_DIR" && touch "$CRON_FILE" && chmod 600 "$CRON_FILE"

sed -i '/config_update.sh/d' "$CRON_FILE"

echo "0 */$UPDATE_INTERVAL * * * bash /app/config_update.sh cron" >> "$CRON_FILE"

pgrep -x "crond" >/dev/null || crond -b
