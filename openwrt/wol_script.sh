#!/bin/sh

# Wake-on-Lan script
# Intended usages:
# 1. suspend a host on a cron schedule
# 2. wake a host on-demand, e.g. from a iot button or remote connection

# invoke as follows
# - `MAC_ADDR=<macaddr> wol_script start`
# - `REMOTE_USER=<username> HOST=<ip> wol_script stop`
# assume for wake:
# - etherwake on openwrt `opkg update && opkg install etherwake`
# - ethtool enabled on host, host configured to 'wake on lan'
# - WoL enabled in target bios
# assume for suspend:
# - client has passwordless sudo and passwordless ssh on host, or REMOTE_USER is root
# - systemctl suspend works
# - $REMOTE_USER has power management, same ethtool


case "$1" in
    start)
        # The following are required:
        # Wake-on-LAN command
        etherwake -i ${LOCAL_IFACE:?} ${MAC_ADDR:?}

        ;;
    stop)
        # suspend system, TODO fix to not use sudo
        # for now this is not in use
        ssh ${REMOTE_USER:?}@${HOST:?} "sudo systemctl suspend"
        ;;
    *)
        echo "Usage: $0 {start|stop}"
esac
