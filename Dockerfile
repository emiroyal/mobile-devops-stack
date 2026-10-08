FROM python:3.12-alpine
WORKDIR /app
COPY backend_api.py database.json ./
RUN adduser -D appuser && chown -R appuser /app
USER appuser
EXPOSE 9090
CMD ["python3", "backend_api.py"]
