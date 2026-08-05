#!/bin/bash

# Multi-cloud dynamic inventory script
INVENTORY_DIR="$(dirname "$0")"

echo "{"
echo '  "_meta": {'
echo '    "hostvars": {}'
echo '  },'

# Combine all cloud inventories
ansible-inventory -i "$INVENTORY_DIR/aws_ec2.yml" --list 2>/dev/null | jq -r '.all.children // {} | keys[]' | while read group; do
    echo "  \"aws_$group\": {"
    ansible-inventory -i "$INVENTORY_DIR/aws_ec2.yml" --list 2>/dev/null | jq -r ".\"$group\".hosts // []" | jq -r '.[]' | while read host; do
        echo "    \"$host\""
    done
    echo "  },"
done

ansible-inventory -i "$INVENTORY_DIR/azure_rm.yml" --list 2>/dev/null | jq -r '.all.children // {} | keys[]' | while read group; do
    echo "  \"azure_$group\": {"
    ansible-inventory -i "$INVENTORY_DIR/azure_rm.yml" --list 2>/dev/null | jq -r ".\"$group\".hosts // []" | jq -r '.[]' | while read host; do
        echo "    \"$host\""
    done
    echo "  },"
done

ansible-inventory -i "$INVENTORY_DIR/gcp_compute.yml" --list 2>/dev/null | jq -r '.all.children // {} | keys[]' | while read group; do
    echo "  \"gcp_$group\": {"
    ansible-inventory -i "$INVENTORY_DIR/gcp_compute.yml" --list 2>/dev/null | jq -r ".\"$group\".hosts // []" | jq -r '.[]' | while read host; do
        echo "    \"$host\""
    done
    echo "  }"
done

echo "}"
