#!/bin/sh
set -uo pipefail

request_limit="43200" # 12 hours

dry_run_flag=""
if [ "$DRY_RUN" = "true" ]
then
  dry_run_flag="--dry-run"
fi

last_run_time="$(cat data/.lastrun 2> /dev/null)"
let "since_last_run = $( date +%s ) - last_run_time"
if [[ "$since_last_run" -lt "$request_limit" ]]
then
  echo "Last update was less than $request_limit seconds ago, exiting"
  exit 0
fi

echo "Updating certs with params dry_run:'$dry_run_flag', email:'$EMAIL', domains:'$DOMAINS'"
./venv/bin/certbot certonly --config-dir data/config --work-dir data/work --logs-dir data/log \
    $dry_run_flag \
    --standalone \
    -n --agree-tos \
    -m "$EMAIL" \
    -d "$DOMAINS"

date +%s > data/.lastrun
