# Use the official Nginx image from Docker Hub
FROM nginx:latest

# Copy a simple static HTML file to the Nginx server
COPY index.html /usr/share/nginx/html/index.html


# Run Nginx 
