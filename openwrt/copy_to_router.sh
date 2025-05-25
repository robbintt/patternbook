#!/bin/bash

USER=root
ROUTER_IP=192.168.1.1
DIR="/root/"

# loop over files in the future
scp wol_script.sh $USER@$ROUTER_IP:$DIR
