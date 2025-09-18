# Stage 1: Builder
FROM python:3.7 AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

# Stage 2: Base Image
FROM python:3.7-slim
WORKDIR /app

# Copy dependencies from builder stage
COPY --from=builder /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/

# Copy application files
COPY . .

ENTRYPOINT ["python", "run.py"]
