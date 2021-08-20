build:
	buildah bud -t ovn .

convertdbs:
	/bin/bash convertdbs.sh

run: convertdbs
	podman run --rm --name ovn -d --volume /tmp/ovn-databases:/etc/ovn:Z -it ovn /bin/bash

exec:
	podman exec -it ovn /bin/bash

plot:
	/bin/bash plot.sh "$(FILTER)"

stop:
	podman stop ovn

logs:
	podman logs ovn
