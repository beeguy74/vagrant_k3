#!/bin/bash

HOSTS_FILE="/etc/hosts"

# Check if the lines already exist in the hosts file
if grep -Fxq "192.168.56.110  app2.com" "$HOSTS_FILE" && grep -Fxq "192.168.56.110  app1.com" "$HOSTS_FILE"; then
    echo "Lines already exist in $HOSTS_FILE"
else
    # Add the lines to the hosts file
    echo "192.168.56.110  app2.com" | sudo tee -a "$HOSTS_FILE"
    echo "192.168.56.110  app1.com" | sudo tee -a "$HOSTS_FILE"
    echo "Lines added to $HOSTS_FILE"
fi

