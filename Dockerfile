# Use the official WordPress image from the Docker Hub as the base image
FROM wordpress:latest

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Copy any custom configuration files, plugins, or themes to the WordPress directory
# COPY custom-config.php /usr/src/wordpress/wp-config.php
# COPY plugins /usr/src/wordpress/wp-content/plugins/
# COPY themes /usr/src/wordpress/wp-content/themes/

# Expose port 80
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]
