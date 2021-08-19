#!/bin/bash

if [ -f /etc/ovn/ovnnb_db.db ]; then
	ovsdb-server -vconsole:info -vfile:off --log-file=/var/log/ovn/ovsdb-server-nb.log --remote=punix:/var/run/ovn/ovnnb_db.sock --pidfile=/var/run/ovn/ovnnb_db.pid --unixctl=/var/run/ovn/ovnnb_db.ctl --remote=ptcp:9641:localhost /etc/ovn/ovnnb_db.db &
fi

if [ -f /etc/ovn/ovnsb_db.db ]; then
	ovsdb-server -vconsole:info -vfile:off --log-file=/var/log/ovn/ovsdb-server-sb.log --remote=punix:/var/run/ovn/ovnsb_db.sock --pidfile=/var/run/ovn/ovnsb_db.pid --unixctl=/var/run/ovn/ovnsb_db.ctl --remote=ptcp:9642:localhost /etc/ovn/ovnsb_db.db &
fi
sleep infinity
