#!/bin/bash

ovsdb-server -vconsole:info -vfile:off --log-file=/var/log/ovn/ovsdb-server-nb.log --remote=punix:/var/run/ovn/ovnnb_db.sock --pidfile=/var/run/ovn/ovnnb_db.pid --unixctl=/var/run/ovn/ovnnb_db.ctl --remote=db:OVN_Northbound,NB_Global,connections /etc/ovn/ovnnb_db.db &
ovsdb-server -vconsole:info -vfile:off --log-file=/var/log/ovn/ovsdb-server-sb.log --remote=punix:/var/run/ovn/ovnsb_db.sock --pidfile=/var/run/ovn/ovnsb_db.pid --unixctl=/var/run/ovn/ovnsb_db.ctl --remote=db:OVN_Southbound,SB_Global,connections /etc/ovn/ovnsb_db.db &
sleep infinity
