#!/bin/bash
set -e

echo "→ Installing security tools..."
sudo apt update
sudo apt install -y ufw fail2ban

# ufw
echo "→ Configuring UFW..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable

# fail2ban
echo "→ Configuring fail2ban..."
sudo bash -c 'cat > /etc/fail2ban/jail.local' << 'EOF'
[sshd]
enabled  = true
port     = 22
filter   = sshd
logpath  = /var/log/auth.log
maxretry = 3
findtime = 10m
bantime  = 1h
EOF

sudo systemctl enable fail2ban
sudo systemctl restart fail2ban

# ssh — make sure your key is added before running this
echo "→ Hardening SSH..."
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*MaxAuthTries.*/MaxAuthTries 3/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "✓ Server hardening complete"
echo "  WARNING: Password authentication is now disabled."
echo "  Make sure your SSH key works before closing this session."
