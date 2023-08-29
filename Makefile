DB_LOCATION ?= /tmp/ovn-databases

build: # Build the container.
	podman build -t ovn .

normalizedbs: # Normalize the dbs (extract them and rename them) from must-gather format to the OVN expected names. Specify DB_LOCATION for a custom location, default /tmp/ovn-databases
	podman run --rm --name ovn --volume $(DB_LOCATION):/etc/ovn:Z,U --entrypoint="" -it ovn /scripts/normalizedbs.sh

convertdbs: normalizedbs # Convert the databases from clustered to standalone. Specify DB_LOCATION for a custom location, default /tmp/ovn-databases.
	podman run --rm --name ovn --volume $(DB_LOCATION):/etc/ovn:Z,U --entrypoint="" -it ovn /scripts/convertdbs.sh

run: convertdbs # Run the container. Specify DB_LOCATION for a custom location, default /tmp/ovn-databases.
	podman run --rm --name ovn -d -p 39641:9641 -p 39642:9642 --volume $(DB_LOCATION):/etc/ovn:Z,U -it ovn /scripts/entrypoint.sh

exec: # Connect to the container for interactive analysis.
	podman exec -it ovn /bin/bash

plot: # Generate a plot of the OVN databases.
	/bin/bash plot.sh "$(FILTER)"

stop: # Stop the container.
	podman stop ovn

remove: # Remove the container.
	podman rm ovn

logs: # Print logs.
	podman logs ovn

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done
