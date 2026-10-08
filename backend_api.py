import json
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

class MicroserviceAPI(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/api/v1/status':
            self.send_response(200)
            self.send_header('Access-Control-Allow-Origin', '*')
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            
            # 📁 LIVE DEVOPS STORAGE CHECK: Read the persistent database file
            db_path = 'database.json'
            if os.path.exists(db_path):
                with open(db_path, 'r') as file:
                    cluster_data = json.load(file)
            else:
                # Fallback data if file goes missing
                cluster_data = {"active_users": 0, "status": "DATABASE_ERROR"}
            
            # Send the dynamic data back to the frontend browser
            self.wfile.write(json.dumps(cluster_data).encode())
        else:
            self.send_response(404)
            self.end_headers()

def run():
    server_address = ('', 9090)
    httpd = HTTPServer(server_address, MicroserviceAPI)
    print("[INFO] DevOps Backend Microservice booting on port 9090...")
    httpd.serve_forever()

if __name__ == '__main__':
    run()
