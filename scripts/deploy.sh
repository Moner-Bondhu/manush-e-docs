#!/bin/bash
set -e

echo "Deploying MkDocs site..."

# Change to the deployment directory
cd /var/www/manush-e-docs

# Install dependencies if needed
pip install -r requirements.txt || true

# Build the documentation site
mkdocs build --clean

# Set permissions
sudo chown -R www-data:www-data /var/www/manush-e-docs/site

# Restart Apache to apply changes
sudo systemctl reload apache2

echo "Deployment complete!"
