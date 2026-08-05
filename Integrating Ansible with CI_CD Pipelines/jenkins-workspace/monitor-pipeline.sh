#!/bin/bash

echo "=== Jenkins + Ansible CI/CD Pipeline Monitor ==="
echo "Monitoring started at $(date)"
echo

# Check Jenkins service
echo "1. Jenkins Service Status:"
if sudo systemctl is-active --quiet jenkins; then
    echo "   ✓ Jenkins is running"
    echo "   Port 8080: $(sudo netstat -tlnp | grep :8080 | wc -l) connections"
else
    echo "   ✗ Jenkins is not running"
fi

# Check Ansible installation
echo "2. Ansible Status:"
if command -v ansible >/dev/null 2>&1; then
    echo "   ✓ Ansible is installed: $(ansible --version | head -n1)"
else
    echo "   ✗ Ansible is not installed"
fi

# Check application deployment
echo "3. Application Status:"
if curl -s http://localhost >/dev/null 2>&1; then
    echo "   ✓ Application is accessible"
    echo "   HTTP Status: $(curl -s -o /dev/null -w "%{http_code}" http://localhost)"
else
    echo "   ✗ Application is not accessible"
fi

# Check nginx status
echo "4. Nginx Status:"
if sudo systemctl is-active --quiet nginx; then
    echo "   ✓ Nginx is running"
    echo "   Configuration test: $(sudo nginx -t 2>&1 | grep -o 'successful' || echo 'failed')"
else
    echo "   ✗ Nginx is not running"
fi

# Check recent Jenkins builds
echo "5. Recent Jenkins Activity:"
if [ -d "/var/lib/jenkins/jobs" ]; then
    echo "   Available jobs:"
    ls /var/lib/jenkins/jobs/ | sed 's/^/   - /'
else
    echo "   No Jenkins jobs found"
fi

echo
echo "=== Monitoring completed at $(date) ==="
