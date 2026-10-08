#!/bin/sh

BACKUP_DIR="/root/my-web-project/backups"
DB_FILE="/root/my-web-project/database.json"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

echo "📦 [DEVOPS BACKUP SYSTEM] Initializing safety backup routine..."

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "📁 Created missing backup repository directory structure."
fi

if [ -f "$DB_FILE" ]; then
    tar -czf "$BACKUP_DIR/db_snapshot_$TIMESTAMP.tar.gz" -C "/root/my-web-project" "database.json"
    echo "🔒 [SUCCESS] Persistent database securely backed up!"
    echo "📄 Snapshot Archive: backups/db_snapshot_$TIMESTAMP.tar.gz"
else
    echo "❌ [ERROR] Crucial source database.json file not found! Backup aborted."
fi
