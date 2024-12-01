#!/bin/sh

SEND_TELEGRAM="/root/send_telegram.sh"
#mapping interface dengan nama ISP
INTERFACE_MAP="
wan1:biznet
wwan1:telkomsel
"

map_interface_name() {
    ORIGINAL_NAME=$1
    for MAPPING in $INTERFACE_MAP; do
        IFACE_ORIG=$(echo $MAPPING | cut -d':' -f1)
        IFACE_NEW=$(echo $MAPPING | cut -d':' -f2)
        if [ "$ORIGINAL_NAME" = "$IFACE_ORIG" ]; then
            echo "$IFACE_NEW"
            return
        fi
    done
    echo "$ORIGINAL_NAME"
}

notify_telegram() {
    INTERFACE=$1
    STATUS=$2
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    FRIENDLY_NAME=$(map_interface_name "$INTERFACE")
    MESSAGE="MWAN3 Alert: Interface $FRIENDLY_NAME ($INTERFACE) is $STATUS at $TIMESTAMP" #struktur pesan allert
    $SEND_TELEGRAM "$MESSAGE"
}

case "$ACTION" in
    ifdown)
        notify_telegram "$INTERFACE" "DOWN"
        ;;
    ifup)
        notify_telegram "$INTERFACE" "UP"
        ;;
esac
