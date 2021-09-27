build:
	buildah bud -t ovn .

convertdbs:
	/bin/bash convertdbs.sh

run: convertdbs
	podman run --rm --name ovn -d -p 39641:9641 --volume /tmp/ovn-databases:/etc/ovn:Z -it ovn /bin/bash

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
