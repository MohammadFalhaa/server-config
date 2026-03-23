#!/bin/bash
set -e

echo "→ Installing PostgreSQL..."
sudo apt update
sudo apt install -y postgresql postgresql-contrib

echo "→ Starting PostgreSQL service..."
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "✓ PostgreSQL installed"
echo "  Connect with: sudo -u postgres psql"
echo ""
echo "  To enable an extension inside psql:"
echo "  CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
