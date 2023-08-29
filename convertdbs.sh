#!/bin/bash
# Convert all database files from clustered to standalone.

DB_DIR=/etc/ovn
for f in /etc/ovn/*db; do
    if ovsdb-tool db-is-clustered "${f}" ; then
        echo "${f} is clustered, converting"
        mv "${f}"{,.clustered}
        ovsdb-tool cluster-to-standalone "${f}"{,.clustered}
        chmod +r "${f}"
    fi
done

# Cleanup.
rm -f "${DB_DIR}"/.ovn*
