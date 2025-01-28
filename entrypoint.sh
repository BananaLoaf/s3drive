#!/bin/bash

# Generate rclone configuration
mkdir -p /root/.config/rclone
cat << EOF > /root/.config/rclone/rclone.conf
[gdrive]
type = drive
scope = ${RCLONE_GDRIVE_SCOPE}
token = ${RCLONE_GDRIVE_TOKEN}
team_drive = 

[minio]
type = s3
provider = ${RCLONE_S3_PROVIDER}
endpoint = ${RCLONE_S3_ENDPOINT}
access_key_id = ${RCLONE_S3_ACCESS_KEY_ID}
secret_access_key = ${RCLONE_S3_SECRET_ACCESS_KEY}
EOF


# Setup cron schedule
echo "${SYNC_SCHEDULE} /usr/bin/flock -n /tmp/lock rclone sync minio:${S3_BUCKET} gdrive:${GDRIVE_FOLDER} --progress --transfers=4 --checkers=10" | crontab -

# Start cron in foreground
crond -l 2 -f
