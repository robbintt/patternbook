#!/bin/bash

# enable on first run to turn sudoers pw off
# ansible-playbook -i hosts pine64.yml --ask-sudo-pass --ask-vault-pass --verbose --connection=local
ansible-playbook -i hosts pine64.yml --ask-vault-pass --verbose --connection=local
