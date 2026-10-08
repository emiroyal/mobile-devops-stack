#!/bin/sh

echo "📊 [DEVOPS MONITORING ENGINE] Initializing Live Resource Monitor Dashboard..."
echo "🖥️ Tracking Host: Termux Mobile Alpine Kernel"
echo "Press CTRL+C to stop the dashboard monitor thread."
echo "=========================================================="
sleep 1

while true; do
    clear
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    
    echo "=========================================================="
    echo " 📈 CLUSTER HEALTH DASHBOARD | $TIMESTAMP "
    echo "=========================================================="
    
    # 1. Fetch Disk Storage Metrics
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
    echo "💾 [DISK SPACE]   Root Filesystem Allocation: $DISK_USAGE"
    
    # 2. 🛡️ FIXED MICROSERVICES METRIC: Parse ps -ef table directly
    PYTHON_PROCS=$(ps -ef | grep "python3" | grep -v "grep" | wc -l)
    echo "📡 [MICROSERVICES] Active Background Engines: $PYTHON_PROCS python3 pools"
    
    # 3. Read Database State File Check
    if [ -f "/root/my-web-project/database.json" ]; then
        USERS=$(cat /root/my-web-project/database.json | grep active_users | tr -cd '0-9')
        echo "🗄️  [DATABASE LOG] Current Logged Active Users: $USERS"
    else
        echo "🗄️  [DATABASE LOG] STATUS: CRITICAL_OFFLINE"
    fi
    
    echo "=========================================================="
    echo "System Status: OPERATIONAL | Refreshing every 2 seconds..."
    
    sleep 2
done
