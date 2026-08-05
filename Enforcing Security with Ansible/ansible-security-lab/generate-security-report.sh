#!/bin/bash
echo "=== COMPREHENSIVE SECURITY REPORT ==="
echo "Generated on: $(date)"
echo "Hostname: $(hostname)"
echo "User: $(whoami)"
echo ""

echo "=== SSH SECURITY CONFIGURATION ==="
echo "SSH Configuration File: /etc/ssh/sshd_config"
grep -E "PermitRootLogin|PasswordAuthentication|MaxAuthTries|AllowGroups|ClientAlive" /etc/ssh/sshd_config
echo ""

echo "=== FIREWALL CONFIGURATION ==="
sudo ufw status verbose
echo ""

echo "=== FAIL2BAN STATUS ==="
sudo fail2ban-client status
echo ""

echo "=== NETWORK SERVICES ==="
sudo netstat -tuln | grep LISTEN
echo ""

echo "=== SYSTEM SECURITY UPDATES ==="
apt list --upgradable 2>/dev/null | head -10
echo ""

echo "=== RECENT SECURITY EVENTS ==="
sudo grep -i "failed\|error\|denied" /var/log/auth.log | tail -5
echo ""

echo "=== FILE PERMISSIONS CHECK ==="
ls -la /etc/ssh/sshd_config /etc/shadow /etc/passwd
echo ""

echo "=== SECURITY REPORT COMPLETE ==="
