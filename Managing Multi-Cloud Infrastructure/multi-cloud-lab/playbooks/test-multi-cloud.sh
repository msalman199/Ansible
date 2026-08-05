#!/bin/bash

echo "Testing Multi-Cloud Infrastructure..."

# Test AWS connectivity
echo "Testing AWS instances..."
ansible all -i inventories/aws_ec2.yml -m ping --one-line

# Test Azure connectivity
echo "Testing Azure instances..."
ansible all -i inventories/azure_rm.yml -m ping --one-line

# Test GCP connectivity
echo "Testing GCP instances..."
ansible all -i inventories/gcp_compute.yml -m ping --one-line

# Gather facts from all clouds
echo "Gathering facts from all clouds..."
ansible all -i inventories/aws_ec2.yml -m setup --tree /tmp/facts/aws/
ansible all -i inventories/azure_rm.yml -m setup --tree /tmp/facts/azure/
ansible all -i inventories/gcp_compute.yml -m setup --tree /tmp/facts/gcp/

echo "Multi-cloud testing completed!"
