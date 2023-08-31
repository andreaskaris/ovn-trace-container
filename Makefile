DB_LOCATION ?= /tmp/ovn-databases
OUTPUT_DIR ?= $(shell pwd)/output

build: # Build the container.
	podman build -t ovn .

normalizedbs: # Normalize the dbs (extract them and rename them) from must-gather format to the OVN expected names. Specify DB_LOCATION for a custom location, default /tmp/ovn-databases
	podman run --rm --name ovn --volume $(DB_LOCATION):/etc/ovn:Z,U --entrypoint="" -it ovn /scripts/normalizedbs.sh

convertdbs: normalizedbs # Convert the databases from clustered to standalone. Specify DB_LOCATION for a custom location, default /tmp/ovn-databases.
	podman run --rm --name ovn --volume $(DB_LOCATION):/etc/ovn:Z,U --entrypoint="" -it ovn /scripts/convertdbs.sh

run: convertdbs # Run the container. Specify DB_LOCATION for a custom location, default /tmp/ovn-databases.
	podman run --rm --name ovn -d --volume $(OUTPUT_DIR):/output:Z,U --volume $(DB_LOCATION):/etc/ovn:Z,U -it ovn /scripts/entrypoint.sh

exec: # Connect to the container for interactive analysis.
	podman exec -it ovn /bin/bash

plot: clean-plot # Generate a plot of the OVN databases.
	podman exec -it ovn /usr/bin/ovnkube-plot.sh "$(FILTER)"

clean-plot:
	rm -f output/*

stop: # Stop the container.
	podman stop ovn

logs: # Print logs.
	podman logs ovn

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done
