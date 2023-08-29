#!/bin/bash

DB_TYPE="${1}"
OVN_COMMAND=""

usage() {
    echo "ovn.sh [nb|sb] [--list]"
    echo "ovn.sh [nb|sb] [socket name from --list] [commands to send to ovn-nbctl or ovn-sbctl]"
}

if [ "${DB_TYPE}" == "nb" ]; then
   OVN_COMMAND="ovn-nbctl"
elif [ "${DB_TYPE}" == "sb" ]; then
   OVN_COMMAND="ovn-sbctl"
else
    usage
    exit 1
fi

COMMAND="${2}"
if [ "${COMMAND}" == "--help" ] || [ "${COMMAND}" == "-h" ]; then
    usage
    exit 1
fi

if [ "${COMMAND}" == "--list" ]; then
    if [ "${OVN_COMMAND}" == "ovn-nbctl" ]; then
        for f in /var/run/ovn/*nbdb.sock; do
            basename "${f}" | sed 's/\.sock$//'
        done
    else
        for f in /var/run/ovn/*sbdb.sock; do
            basename "${f}" | sed 's/\.sock$//'
        done
    fi
    exit 0
fi

DB="${2}"
${OVN_COMMAND} --db="unix:/var/run/ovn/${DB}.sock" "${@:3}"
