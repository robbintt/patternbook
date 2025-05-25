# Wake-on-lan Ansible Role

This creates a systemd unit file to enable wake-on-lan on startup

## Requirements

- define `eth_device` in the group_vars or playbook.
- systemd
- tested on ubuntu
