FROM alpine:latest
RUN apk update && apk add bash python3
WORKDIR /root/my-web-project
COPY . .
CMD ["sh", "-c", "python3 backend_api.py & python3 -m http.server 8080"]
