#!/bin/bash

DB_DIR=/etc/ovn
NBDB=ovnnb_db.db
SBDB=ovnsb_db.db
if $(ovsdb-tool db-is-clustered ${DB_DIR}/${NBDB}) ; then
    echo "NBDB file is clustered, converting"
    mv ${DB_DIR}/${NBDB}{,.clustered}
    ovsdb-tool cluster-to-standalone ${DB_DIR}/${NBDB}{,.clustered}
    chmod +r ${DB_DIR}/${NBDB}
    rm -f ${DB_DIR}/.ovn*
fi
if $(ovsdb-tool db-is-clustered ${DB_DIR}/${SBDB}) ; then
    echo "SBDB file is clustered, converting"
    mv ${DB_DIR}/${SBDB}{,.clustered}
    ovsdb-tool cluster-to-standalone ${DB_DIR}/${SBDB}{,.clustered}
    chmod +r ${DB_DIR}/${SBDB}
    rm -f ${DB_DIR}/.ovn*
fi
