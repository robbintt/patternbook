#!/bin/bash

# use --ask-become-pass on first run to turn sudoers pw off
#ansible-playbook -i hosts ubuntu.yml --ask-become-pass --verbose --connection=local
ansible-playbook -i hosts ubuntudesktop.yml --verbose --connection=local
