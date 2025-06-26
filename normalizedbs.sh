#!/bin/bash
# Extract databases in the same location, and rename them for legacy mode.

DB_DIR=/etc/ovn
MG_NBDB=leader_nbdb
MG_SBDB=leader_sbdb
NBDB=ovnnb_db
SBDB=ovnsb_db
MG_ICDB=ovnk_database_store.tar.gz
NBDB_WITH_SUFFIX=ovnnb_db.db
SBDB_WITH_SUFFIX=ovnsb_db.db

pushd "${DB_DIR}" || exit

# Legacy mode.
if [ -f "${MG_NBDB}".gz ]; then
    gunzip "${MG_NBDB}".gz
    mv "${MG_NBDB}" "${NBDB}"
fi
if [ -f "${MG_SBDB}".gz ]; then
    gunzip "${MG_SBDB}".gz
    mv "${MG_SBDB}" "${SBDB}"
fi

# OVN IC.
if [ -f "${MG_ICDB}" ]; then
    tar --strip-components 1 -xf "${MG_ICDB}"
fi

# Upstream OVN has a different naming convention.
if [ -f "${NBDB_WITH_SUFFIX}" ]; then
    mv "${NBDB_WITH_SUFFIX}" "${NBDB}"
fi
if [ -f "${SBDB_WITH_SUFFIX}" ]; then
    mv "${SBDB_WITH_SUFFIX}" "${SBDB}"
fi
