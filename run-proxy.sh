#!/bin/bash

#
# Salt-Proxy Run Script
#

set -e

# Log Level
LOG_LEVEL=${LOG_LEVEL:-"debug"}

sed -i "s|server|$MASTER|g" /etc/salt/proxy

# Run Salt as a Deamon
exec /usr/bin/salt-proxy --log-level=$LOG_LEVEL --proxyid=$PROXYID
