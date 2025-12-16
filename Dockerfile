# 1. Choose base image
FROM nginx:stable-alpine

# 2. Remove default site config (optional) and copy our config to nginx's conf.d
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# 3. Copy your static files into nginx html directory
COPY myapp /usr/share/nginx/html

# 4. Expose port 80(HTTP) and 443(HTTPS) (informational for users of the image)
EXPOSE 80 
EXPOSE 443 
# 5. Default CMD from official image runs nginx in foreground,
#    so we don't override it here and the image will start nginx automatically.
