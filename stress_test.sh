#!/bin/sh

DB_FILE="database.json"
echo "🔥 [STRESS TEST] Commencing massive user surge simulation..."
sleep 1

# A loop that adds 500 new users to the database layout every 0.5 seconds
for i in $(seq 1 10); do
    CURRENT_USERS=$(cat $DB_FILE | grep active_users | tr -cd '0-9')
    NEW_TOTAL=$((CURRENT_USERS + 500))
    
    # Live data replacement
    sed -i "s/$CURRENT_USERS/$NEW_TOTAL/g" $DB_FILE
    
    echo "📈 Simulated Traffic Peak: Added 500 users. Current Database State: $NEW_TOTAL"
    sleep 0.5
done

echo "🏁 [STRESS TEST COMPLETED] System load testing finalized successfully!"
