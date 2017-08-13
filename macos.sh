#!/bin/bash

# if you need sudo, use this:
# ansible-playbook -i hosts macosx.yml --ask-vault-pass --ask-become-pass --verbose --connection=local

# this is often set to prevent accidental global pip installs
unset PIP_REQUIRE_VIRTUALENV

ansible-playbook -i hosts macos.yml --ask-vault-pass -vvv --connection=local
