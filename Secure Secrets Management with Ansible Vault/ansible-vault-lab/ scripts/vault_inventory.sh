#!/bin/bash
# Vault inventory management script

VAULT_DIR="$HOME/ansible-vault-lab/vault_files"
VAULT_PASS_FILE="$HOME/.vault_pass"

echo "=== Ansible Vault Inventory ==="
echo "Vault Directory: $VAULT_DIR"
echo "================================"

for vault_file in "$VAULT_DIR"/*.yml; do
    if [ -f "$vault_file" ]; then
        echo "File: $(basename "$vault_file")"
        echo "Size: $(stat -c%s "$vault_file") bytes"
        echo "Modified: $(stat -c%y "$vault_file")"
        
        # Try to get variable count
        var_count=$(ansible-vault view "$vault_file" --vault-password-file "$VAULT_PASS_FILE" 2>/dev/null | grep -c "^[a-zA-Z]" || echo "encrypted")
        echo "Variables: $var_count"
        echo "---"
    fi
done
