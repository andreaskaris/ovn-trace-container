## Building the container

Build the container first with:
```
make build
```

## Run the container

You can run the container with the following command, where DB_LOCATION is the path to the must-gather:
```
make run DB_LOCATION=must-gather/network_logs/
```
> **Note:** This will extract your database archives in that location.

Check the logs, everything should be ok:
```
$ make logs
podman logs ovn
2021-08-12T16:05:01Z|00001|vlog|INFO|opened log file /var/log/ovn/ovsdb-server-nb.log
2021-08-12T16:05:01Z|00001|vlog|INFO|opened log file /var/log/ovn/ovsdb-server-sb.log
2021-08-12T16:05:01Z|00002|ovsdb_server|INFO|ovsdb-server (Open vSwitch) 2.15.0
```

## Connect to the container

In order to inspect the database contents, connect to the container.
```
make exec
```

### OVN-Kubernetes legacy mode

Run ovn-nbctl and ovn-sbctl directly, e.g.:
```
# ovn-nbctl show
# ovn-sbctl show
```

### OVN-Kubernetes IC mode

First, list all NB and SB databases:
```
bash-5.2# ovn.sh nb --list
ovnkube-node-2j658_nbdb
ovnkube-node-7cc6h_nbdb
ovnkube-node-g7thw_nbdb
ovnkube-node-nbt9h_nbdb
ovnkube-node-rgw4g_nbdb
ovnkube-node-t899w_nbdb
bash-5.2# ovn.sh sb --list
ovnkube-node-2j658_sbdb
ovnkube-node-7cc6h_sbdb
ovnkube-node-g7thw_sbdb
ovnkube-node-nbt9h_sbdb
ovnkube-node-rgw4g_sbdb
ovnkube-node-t899w_sbdb
```

Then, run OVN NB / SB commands against the databases that you want to inspect:
```
bash-5.2# ovn.sh nb ovnkube-node-t899w_nbdb show | head
switch de8555b8-95f2-47d6-b2de-9778af4fa41e (join)
    port jtor-GR_ip-10-0-124-118.ec2.internal
        type: router
        router-port: rtoj-GR_ip-10-0-124-118.ec2.internal
    port jtor-ovn_cluster_router
        type: router
        router-port: rtoj-ovn_cluster_router
switch aa47d120-ba2a-4271-8594-3ac39f7dde20 (transit_switch)
    port tstor-ip-10-0-30-101.ec2.internal
        type: remote
bash-5.2# ovn.sh sb ovnkube-node-t899w_sbdb show | head
Chassis "89e969c1-0069-4758-96f9-29c63a8b9f0e"
    hostname: ip-10-0-87-25.ec2.internal
    Encap geneve
        ip: "10.0.87.25"
        options: {csum="true"}
    Port_Binding tstor-ip-10-0-87-25.ec2.internal
Chassis "b687401f-4a1a-4a9b-8a06-bbe2ce64bc23"
    hostname: ip-10-0-124-118.ec2.internal
    Encap geneve
        ip: "10.0.124.118"
```

## Run the OVN trace command

### Legacy mode
```
make exec
ovn-trace  --ct=new --ct=new 'inport=="(...)" && eth.dst==aa:aa:aa:aa:aa:aa && eth.src==bb:bb:bb:bb:bb:bb && ip4.dst==192.168.123.1 && ip4.src==192.168.123.2 && ip.ttl==64 && tcp.dst==53 && tcp.src==50000'
```

It will take a while to execute the commands, and one will see a few warning:
```
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
```

### IC mode

Not yet implemented.

## Stop and remove the container

In order to stop and remove the container, run:
```
make stop
```

## Plot the topology

In order to generate a plot of all OVN Northbound databases, run:
```
make plot
```

The output will be stored in directory `output`.

