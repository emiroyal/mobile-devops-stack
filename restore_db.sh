#!/bin/sh

BACKUP_DIR="/root/my-web-project/backups"
TARGET_DIR="/root/my-web-project"

echo "🛠️ [DISASTER RECOVERY] Initializing database restoration sequence..."

# Find the absolute latest timestamped backup archive file in the directory
LATEST_BACKUP=$(ls -t $BACKUP_DIR/db_snapshot_*.tar.gz 2>/dev/null | head -n 1)

if [ -n "$LATEST_BACKUP" ]; then
    echo "📦 Found latest system snapshot archive: $LATEST_BACKUP"
    
    # Extract the compressed database layer back into your live production ground
    tar -xzf "$LATEST_BACKUP" -C "$TARGET_DIR"
    
    echo "⚡ [SUCCESS] Production database state restored to operational status!"
else
    echo "❌ [FATAL ERROR] No system snapshots found in backup vault! Recovery aborted."
fi
