#!/bin/bash

# ansible-playbook -i hosts prod.yml --list-hosts

# restrict to just apache2servers group?
# ansible-playbook -i hosts -l apache2servers prod.yml --ask-vault-pass --verbose

ansible-playbook -i hosts servers.yml -vvv 
