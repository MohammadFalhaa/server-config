#!/bin/bash
set -e

# Server hardening — UFW, fail2ban, SSH config
echo "→ Installing security tools..."
sudo apt update
sudo apt install -y ufw fail2ban

# ── UFW Firewall ────────────────────────────────────────────────────────────────
echo "→ Configuring UFW..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22    # SSH
sudo ufw allow 80    # HTTP
sudo ufw allow 443   # HTTPS
sudo ufw --force enable

# ── fail2ban ────────────────────────────────────────────────────────────────────
# Bans IPs that repeatedly fail SSH authentication.
# Default: ban for 10min after 5 failed attempts within 10min.
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

# ── SSH Hardening ───────────────────────────────────────────────────────────────
# Disables password auth and root login — keys only.
# Make sure your SSH key is added before running this.
echo "→ Hardening SSH..."
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*MaxAuthTries.*/MaxAuthTries 3/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "✓ Server hardening complete"
echo "  WARNING: Password authentication is now disabled."
echo "  Make sure your SSH key works before closing this session."
