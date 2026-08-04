# Webserver Role

This Ansible role installs and configures Apache web server on Ubuntu systems.

## Requirements

- Ubuntu 18.04 or later
- Ansible 2.9 or later
- sudo privileges on target hosts

## Role Variables

### Default Variables (defaults/main.yml)

| Variable | Default Value | Description |
|----------|---------------|-------------|
| `webserver_package` | `apache2` | Apache package name |
| `webserver_service` | `apache2` | Apache service name |
| `webserver_port` | `80` | HTTP port |
| `webserver_document_root` | `/var/www/html` | Document root directory |
| `webserver_index_file` | `index.html` | Default index file |
| `webserver_server_name` | `localhost` | Server name |
| `webserver_admin_email` | `admin@localhost` | Administrator email |
| `site_title` | `Welcome to My Web Server` | Website title |
| `site_message` | `This server was configured using Ansible Roles!` | Welcome message |

## Dependencies

None

## Example Playbook

```yaml
- hosts: webservers
  become: yes
  roles:
    - webserver
