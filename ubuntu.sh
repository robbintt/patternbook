#!/bin/bash

# enable on first run to turn sudoers pw off
#ansible-playbook -i hosts ubuntu.yml --ask-sudo-pass --ask-vault-pass --verbose --connection=local
ansible-playbook -i hosts ubuntu.yml --ask-vault-pass --verbose --connection=local
