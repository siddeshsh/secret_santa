#!/bin/bash

echo "🎄 Gift Exchange - Production Setup Script 🎁"
echo "=============================================="
echo ""

# Check if MySQL is running
echo "1. Checking MySQL status..."
if ! systemctl is-active --quiet mysql; then
    echo "⚠️  MySQL is not running. Starting MySQL..."
    sudo systemctl start mysql
fi

# Prompt for MySQL credentials
echo ""
echo "2. MySQL Credentials Setup"
echo "Please enter your MySQL credentials:"
read -p "MySQL Username (default: root): " MYSQL_USER
MYSQL_USER=${MYSQL_USER:-root}

read -sp "MySQL Password: " MYSQL_PASS
echo ""

# Generate SECRET_KEY_BASE
echo ""
echo "3. Generating SECRET_KEY_BASE..."
cd /home/siddesh/Desktop/gift_exchange
SECRET_KEY=$(rails secret)
echo "✅ Secret key generated"

# Export environment variables
export DATABASE_URL="mysql2://${MYSQL_USER}:${MYSQL_PASS}@localhost/gift_exchange_production"
export SECRET_KEY_BASE="${SECRET_KEY}"
export RAILS_ENV=production

echo ""
echo "4. Creating production database..."
rails db:create RAILS_ENV=production

echo ""
echo "5. Running migrations..."
rails db:migrate RAILS_ENV=production

echo ""
echo "6. Precompiling assets..."
rails assets:precompile RAILS_ENV=production

echo ""
echo "=============================================="
echo "✅ Production setup complete!"
echo ""
echo "To start the production server, run:"
echo ""
echo "DATABASE_URL=\"mysql2://${MYSQL_USER}:${MYSQL_PASS}@localhost/gift_exchange_production\" \\"
echo "SECRET_KEY_BASE=\"${SECRET_KEY}\" \\"
echo "RAILS_ENV=production \\"
echo "rails server -p 3000"
echo ""
echo "Or save these to a file and source it:"
echo "echo 'export DATABASE_URL=\"mysql2://${MYSQL_USER}:${MYSQL_PASS}@localhost/gift_exchange_production\"' > .env.production"
echo "echo 'export SECRET_KEY_BASE=\"${SECRET_KEY}\"' >> .env.production"
echo "echo 'export RAILS_ENV=production' >> .env.production"
echo ""
echo "Then run: source .env.production && rails server"
