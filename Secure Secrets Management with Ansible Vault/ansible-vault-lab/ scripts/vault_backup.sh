#!/bin/bash
# Vault backup script

VAULT_DIR="$HOME/ansible-vault-lab/vault_files"
BACKUP_DIR="$HOME/ansible-vault-lab/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="vault_backup_$TIMESTAMP"

# Create backup directory
mkdir -p "$BACKUP_DIR/$BACKUP_NAME"

echo "Creating vault backup: $BACKUP_NAME"

# Copy all vault files
cp "$VAULT_DIR"/*.yml "$BACKUP_DIR/$BACKUP_NAME/" 2>/dev/null || echo "No vault files to backup"

# Create backup manifest
cat > "$BACKUP_DIR/$BACKUP_NAME/manifest.txt" << EOL
Vault Backup Manifest
Created: $(date)
Source: $VAULT_DIR
Files backed up:
