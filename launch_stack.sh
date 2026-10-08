#!/bin/sh
echo "🚀 [DEVOPS ORCHESTRATION] Initializing Full Stack..."

# Start Backend API in the background (&)
python3 backend_api.py > backend.log 2>&1 &
BACKEND_PID=$!
echo "📡 Backend API microservice launched on Port 9090 (PID: $BACKEND_PID)"

# Start Frontend Server in the background (&)
python3 -m http.server 8080 > frontend.log 2>&1 &
FRONTEND_PID=$!
echo "💻 Frontend web tier launched on Port 8080 (PID: $FRONTEND_PID)"

echo "✅ Deployment Successful! Press CTRL+C to teardown the infrastructure stack."

# Keep script alive and catch shutdown signal
trap "echo '\n🛑 Shutting down cluster...'; kill $BACKEND_PID $FRONTEND_PID; exit" INT
while true; do sleep 1; done
