# s3drive
Mirror S3 bucket to Google Drive

## 1. Auth to your Google Drive

```bash
rclone config
```

https://rclone.org/drive/

## 2. Find your Google Drive token

Navigate to your rclone config (~/.config/rclone/rclone.conf) and find your gdrive configuration with your token

## 3. Run it!

I do it using `docker-compose`

`docker-compose.yml:`
```yml
services:
  s3drive:
    build: https://github.com/BananaLoaf/s3drive.git
    pull_policy: build
    container_name: s3drive
    restart: unless-stopped
    environment:
      - RCLONE_S3_PROVIDER
      - RCLONE_S3_ENDPOINT
      - RCLONE_S3_ACCESS_KEY_ID
      - RCLONE_S3_SECRET_ACCESS_KEY
      - RCLONE_GDRIVE_SCOPE
      - RCLONE_GDRIVE_TOKEN
      - SYNC_SCHEDULE=*/1 * * * *
      - S3_BUCKET=test-bucket
      - GDRIVE_FOLDER=/s3-buckets/test-bucket
```

`.env:`
```bash
RCLONE_S3_PROVIDER=Minio
RCLONE_S3_ENDPOINT=http://localhost:9000/
RCLONE_S3_ACCESS_KEY_ID=s3_access_key_id
RCLONE_S3_SECRET_ACCESS_KEY=s3_secret_access_key
RCLONE_GDRIVE_SCOPE=drive.file
RCLONE_GDRIVE_TOKEN=your_token
```

`RCLONE_S3_PROVIDER` values can be found at https://rclone.org/s3/

For this project to work properly `RCLONE_GDRIVE_SCOPE` can be one of:
- `drive` - Full access all files, excluding Application Data Folder
- `drive.file` - Access to files created by rclone only. These are visible in the drive website. File authorization is revoked when the user deauthorizes the app.