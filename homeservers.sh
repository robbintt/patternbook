#!/bin/bash

# use --ask-become-pass on first run to turn sudoers pw off
ansible-playbook -i hosts homeservers.yml --ask-become-pass --verbose --connection=local
#ansible-playbook -i hosts homeservers.yml --verbose
