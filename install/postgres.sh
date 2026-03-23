#!/bin/bash
set -e

echo "→ Installing PostgreSQL..."
sudo apt update
sudo apt install -y postgresql postgresql-contrib

# postgresql-contrib includes common extensions:
#   uuid-ossp     — generate UUIDs
#   pgcrypto      — hashing and encryption functions
#   hstore        — key-value pairs in a column
#   pg_trgm       — fuzzy text search
#   pg_stat_statements — query performance tracking

echo "→ Starting PostgreSQL service..."
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "✓ PostgreSQL installed"
echo "  Connect with: sudo -u postgres psql"
echo ""
echo "  To enable an extension inside psql:"
echo "  CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
