## Preparing the NB and SB databases

Put the NB and SB databases into folder /tmp/ovn-databases
~~~
$ find /tmp/ovn-databases/
/tmp/ovn-databases/
/tmp/ovn-databases/ovnsb_db.db
/tmp/ovn-databases/ovnnb_db.db
~~~

## Building the container

~~~
make build
~~~

## Convert the databases to standalone

For clustered environments, the DBs must be converted to standalone:
~~~
make convertdbs
~~~

## Run the container

~~~
make run
~~~

Check the logs, everything should be ok:
~~~
$ make logs
podman logs ovn
2021-08-12T16:05:01Z|00001|vlog|INFO|opened log file /var/log/ovn/ovsdb-server-nb.log
2021-08-12T16:05:01Z|00001|vlog|INFO|opened log file /var/log/ovn/ovsdb-server-sb.log
2021-08-12T16:05:01Z|00002|ovsdb_server|INFO|ovsdb-server (Open vSwitch) 2.15.0
~~~

## Run the OVN trace command

~~~
make exec
ovn-trace  --ct=new --ct=new 'inport=="(...)" && eth.dst==aa:aa:aa:aa:aa:aa && eth.src==bb:bb:bb:bb:bb:bb && ip4.dst==192.168.123.1 && ip4.src==192.168.123.2 && ip.ttl==64 && tcp.dst==53 && tcp.src==50000'
~~~

It will take a while to execute the commands, and one will see a few warning:
~~~
(...)
2021-08-12T15:54:42Z|00001|ovsdb_idl|WARN|OVN_Southbound database lacks BFD table (database needs upgrade?)
2021-08-12T15:54:42Z|00002|ovsdb_idl|WARN|Chassis_Private table in OVN_Southbound database lacks nb_cfg_timestamp column (database needs upgrade?)
2021-08-12T15:54:42Z|00003|ovsdb_idl|WARN|Datapath_Binding table in OVN_Southbound database lacks load_balancers column (database needs upgrade?)
2021-08-12T15:54:42Z|00004|ovsdb_idl|WARN|OVN_Southbound database lacks FDB table (database needs upgrade?)
2021-08-12T15:54:42Z|00005|ovsdb_idl|WARN|OVN_Southbound database lacks Load_Balancer table (database needs upgrade?)
2021-08-12T15:54:42Z|00006|ovsdb_idl|WARN|OVN_Southbound database lacks Logical_DP_Group table (database needs upgrade?)
2021-08-12T15:54:42Z|00007|ovsdb_idl|WARN|Logical_Flow table in OVN_Southbound database lacks logical_dp_group column (database needs upgrade?)
2021-08-12T15:54:42Z|00008|ovsdb_idl|WARN|Port_Binding table in OVN_Southbound database lacks up column (database needs upgrade?)

2021-08-12T15:54:56Z|00009|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00010|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00011|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00012|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00013|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00014|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00015|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00016|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00017|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
2021-08-12T15:54:56Z|00018|poll_loop|INFO|wakeup due to [POLLIN] on fd 3 (<->/var/run/ovn/ovnsb_db.sock) at lib/stream-fd.c:157 (96% CPU usage)
(...)
~~~

## Stop and remove the container

~~~
make stop
~~~
