#!/bin/bash
set -e

echo "Deploying MkDocs site..."

# Change to the deployment directory
cd /var/www/manush-e-docs

# Set up a virtual environment
python3 -m venv /var/www/manush-e-docs/.venv

# Activate the virtual environment
source /var/www/manush-e-docs/.venv/bin/activate

# Install MkDocs in the virtual environment
pip install mkdocs

# Build the documentation site
mkdocs build --clean

# Set permissions
sudo chown -R www-data:www-data /var/www/manush-e-docs/site

# Restart Apache to apply changes
sudo systemctl reload apache2

echo "Deployment complete!"
