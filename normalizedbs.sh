#!/bin/bash

DB_DIR=/etc/ovn
MG_NBDB=leader_nbdb
MG_SBDB=leader_sbdb
NBDB=ovnnb_db.db
SBDB=ovnsb_db.db

if [ -f "${DB_DIR}/${MG_NBDB}".gz ]; then
    gunzip "${DB_DIR}/${MG_NBDB}".gz
    mv "${DB_DIR}/${MG_NBDB}" "${DB_DIR}/${NBDB}"
fi
if [ -f "${DB_DIR}/${MG_SBDB}".gz ]; then
    gunzip "${DB_DIR}/${MG_SBDB}".gz
    mv "${DB_DIR}/${MG_SBDB}" "${DB_DIR}/${SBDB}"
fi
