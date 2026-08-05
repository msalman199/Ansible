#!/bin/bash

echo "=== Deployment Testing Script ==="
echo "Testing deployment at $(date)"
echo

# Test 1: Check if nginx is running
echo "Test 1: Checking nginx service status..."
if sudo systemctl is-active --quiet nginx; then
    echo "✓ PASS: Nginx is running"
else
    echo "✗ FAIL: Nginx is not running"
    exit 1
fi

# Test 2: Check if port 80 is listening
echo "Test 2: Checking if port 80 is listening..."
if sudo netstat -tlnp | grep -q ":80 "; then
    echo "✓ PASS: Port 80 is listening"
else
    echo "✗ FAIL: Port 80 is not listening"
    exit 1
fi

# Test 3: HTTP response test
echo "Test 3: Testing HTTP response..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)
if [ "$HTTP_CODE" = "200" ]; then
    echo "✓ PASS: HTTP response code is 200"
else
    echo "✗ FAIL: HTTP response code is $HTTP_CODE"
    exit 1
fi

# Test 4: Content verification
echo "Test 4: Verifying application content..."
if curl -s http://localhost | grep -q "Application Deployed Successfully"; then
    echo "✓ PASS: Application content is correct"
else
    echo "✗ FAIL: Application content is incorrect"
    exit 1
fi

# Test 5: Build number verification
echo "Test 5: Checking build number in content..."
CONTENT=$(curl -s http://localhost)
if echo "$CONTENT" | grep -q "Build Number:"; then
    echo "✓ PASS: Build number is present in content"
    BUILD_NUM=$(echo "$CONTENT" | grep "Build Number:" | sed 's/.*Build Number: \([^<]*\).*/\1/')
    echo "  Build Number: $BUILD_NUM"
else
    echo "✗ FAIL: Build number not found in content"
fi

echo
echo "=== All tests completed successfully! ==="
echo "Application is accessible at: http://localhost"
