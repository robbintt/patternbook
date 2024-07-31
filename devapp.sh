#!/bin/bash

# ansible-playbook -i hosts prod.yml --list-hosts

ansible-playbook -i hosts devapp.yml -vvv 
