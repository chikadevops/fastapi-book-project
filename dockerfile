# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app
 
# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
 
# Copy application files
COPY . .
 
# Install Nginx app
RUN apt-get update && apt-get install -y nginx
 
# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf
 
# Expose ports for FastAPI (8000) and Nginx (80)
EXPOSE 80 8000

# Start FastAPI and Nginx
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port 8000 & nginx -g 'daemon off;'"]