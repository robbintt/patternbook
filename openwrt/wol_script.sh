#!/bin/sh

# Wake-on-Lan script
# Intended usages:
# 1. suspend a host on a cron schedule
# 2. wake a host on-demand, e.g. from a iot button or remote connection

# invoke as follows
# - `MAC_ADDR=<macaddr> wol_script start`
# - `REMOTE_USER=<username> HOST=<ip> wol_script stop`
# assume:
# - ethtool on host
# - etherwake on openwrt `opkg update && opkg install etherwake`
# - systemctl suspend works
# - WoL enabled in bios
# - $REMOTE_USER has power management and ethtool


case "$1" in
    start)
        # The following are required:
        # Wake-on-LAN command
        etherwake ${MAC_ADDR:?}

        ;;
    stop)
        # suspend system
        ssh ${REMOTE_USER:?}@${HOST:?} "sudo systemctl suspend"
        ;;
    *)
        echo "Usage: $0 {start|stop}"
esac
