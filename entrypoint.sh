#!/bin/bash
# Entrypoint for the OVN trace container.

# OVN IC mode
port=9641
for f in /etc/ovn/ovnnb_db /etc/ovn/ovnsb_db /etc/ovn/*bdb; do
    bn=$(basename "${f}")
	ovsdb-server -vconsole:info -vfile:off --log-file="/var/log/ovn/${bn}.log" \
        --remote="punix:/var/run/ovn/${bn}.sock" \
        --pidfile="/var/run/ovn/${bn}.pid" \
        --unixctl="/var/run/ovn/${bn}.ctl" \
        --remote="ptcp:${port}" \
        "/etc/ovn/${bn}" &
    port=$((port+1))
done

sleep infinity
