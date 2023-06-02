build:
	podman build -t ovn .

convertdbs:
	podman run --rm --name ovn --volume /tmp/ovn-databases:/etc/ovn:Z,U --entrypoint="" -it ovn /scripts/convertdbs.sh

run: convertdbs
	podman run --rm --name ovn -d -p 39641:9641 -p 39642:9642 --volume /tmp/ovn-databases:/etc/ovn:Z,U -it ovn /scripts/entrypoint.sh

exec:
	podman exec -it ovn /bin/bash

plot:
	/bin/bash plot.sh "$(FILTER)"

stop:
	podman stop ovn

remove:
	podman rm ovn

logs:
	podman logs ovn
