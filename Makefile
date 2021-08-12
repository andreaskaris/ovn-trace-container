build:
	buildah bud -t ovn .

convertdbs:
	/bin/bash convertdbs.sh

run: convertdbs
	podman run --rm --name ovn -d --volume /tmp/ovn-databases:/etc/ovn:Z -it ovn /bin/bash

make exec:
	podman exec -it ovn /bin/bash

stop:
	podman stop ovn

logs:
	podman logs ovn
