#!/bin/sh

# static route is 192.168.1.151
# still need to put the static route netplan in ansible

IPTABLES=/usr/sbin/iptables # not needed
LOGFILE=/var/log/iptables.log
MACADDR="6c:4b:90:1b:a7:e6" # MAC address of the Ubuntu host
ETHDEV="eth1.1" # Network interface on the router
SERVERIP="192.168.1.151" # IP address of the Ubuntu server

# Ping the server to set initial server status
if ping -c 1 $SERVERIP &> /dev/null; then
  SERVERSTATUS=1 # Server is up
else
  SERVERSTATUS=0 # Server is down
fi

# Function to create and configure LOGDROP chain
setup_iptables() {
  # Create a new chain
  $IPTABLES -N LOGDROP > /dev/null 2> /dev/null

  # Flush the chain
  $IPTABLES -F LOGDROP

  # Create rule to log & drop packets
  $IPTABLES -A LOGDROP -j LOG --log-prefix "IPTABLES LOGDROP: " --log-level 7
  $IPTABLES -A LOGDROP -j DROP

  # Direct new incoming connections on the Minecraft port to the LOGDROP chain
  $IPTABLES -A INPUT -p tcp --syn --dport 25565 -j LOGDROP
}

# Function to send WoL command
wake_server() {
  etherwake -i $ETHDEV $MACADDR
}

# Function to check server status and update iptables rules
update_iptables() {
  # Ping the server; if it responds, modify the iptables rule to allow connections
  if ping -c 1 $SERVERIP &> /dev/null; then
    if [ $SERVERSTATUS -eq 0 ]; then
      $IPTABLES -D INPUT -p tcp --syn --dport 25565 -j LOGDROP
      $IPTABLES -A INPUT -p tcp --dport 25565 -j ACCEPT
      $SERVERSTATUS=1
    fi
  else
    if [ $SERVERSTATUS -eq 1 ]; then
      # If the server doesn't respond, modify the iptables rule to log and drop connections
      $IPTABLES -D INPUT -p tcp --dport 25565 -j ACCEPT
      $IPTABLES -A INPUT -p tcp --syn --dport 25565 -j LOGDROP
      $SERVERSTATUS=0
    fi
  fi
}

# Initial setup
setup_iptables

# Monitor the log file and trigger WoL when a new entry is added
LASTLINE=""
while true; do
  NEWLINE=$(tail -n 1 $LOGFILE)
  truncate -s 0 $LOGFILE
  if [ "$NEWLINE" != "$LASTLINE" ]; then
    wake_server
    LASTLINE=$NEWLINE
  fi

  update_iptables

  sleep 1
done
