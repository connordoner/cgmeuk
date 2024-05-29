FROM alpine:3.20

# Update packages included with base image
RUN apk upgrade

# Install Nginx
RUN apk add nginx

# Copy Nginx configuration
COPY ./config/nginx/default.conf /etc/nginx/http.d/default.conf

# Add test page to Nginx
WORKDIR /var/www/html
COPY ./config/nginx/test.html ./index.html
RUN chown nginx:nginx ./index.html

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]

# Expose Nginx
EXPOSE 80
