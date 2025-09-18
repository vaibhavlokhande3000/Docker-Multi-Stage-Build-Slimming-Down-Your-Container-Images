# Docker Multi-Stage Build: Slimming Down Your Container Images

## Introduction

Docker images—the buffet of the container world. Quick to set up, easy to use, but if you're not careful, they can become bloated and take up more space than your hard drive is willing to offer. 

Enter Docker Multi-Stage Builds, the ultimate weight-loss program for your containers!

Lets see How it works?

What is a Multi-Stage Build?

Think of multi-stage builds as a two-step process:

 Stage 1: The Builder Stage - This is where we install all dependencies, compile code, and prepare everything we need for our app.

 Stage 2: The Slim Runtime - This is where we take only the essential files from the builder stage and leave behind the unnecessary baggage.

## Before vs. After Multi-Stage Build :

Here’s what happens when we use a standard build approach:

```
#Before
FROM python:3.9
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
EXPOSE 80
CMD ["python", "run.py"]

```
And here’s how we trim the unnecessary calories (Libraries) with a multi-stage build:

```
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

```
## What Did We Achieve?

✅ Removed unnecessary build tools from the final image.

✅ Reduced the overall image size drastically. 

✅ Made our Docker build faster and more efficient.

## Real-Life Proof: Image Size Comparison :

<img width="908" height="71" alt="image" src="https://github.com/user-attachments/assets/8f46cee9-794d-4993-9c8a-8047ab540c0a" />

## Conclusion

Docker Multi-Stage Builds help keep your container images small and efficient. They speed up deployment, reduce storage usage, and improve overall performance. If you’re working with large images, switching to a multi-stage approach is an easy win.

Try it out and see the difference in your Docker workflows!
