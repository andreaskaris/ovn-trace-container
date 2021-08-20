#!/bin/bash

FILTER="$1"

if ! [ -d output ];then 
	mkdir output
fi
podman exec -it ovn /bin/bash -c "/scripts/ovnkube-plot --filter='${FILTER}' --nb-address=tcp://localhost:9641 2>/dev/null" > output/compact.txt
cat output/compact.txt | dot -Tpdf > output/compact.pdf
cat output/compact.txt | dot -Tsvg > output/compact.svg
cat output/compact.txt | dot -Tpng > output/compact.png

podman exec -it ovn /bin/bash -c "/scripts/ovnkube-plot --format=detailed --nb-address=tcp://localhost:9641 2>/dev/null" > output/detailed.txt
cat output/detailed.txt | dot -Tpdf > output/detailed.pdf
cat output/detailed.txt | dot -Tsvg > output/detailed.svg
cat output/detailed.txt | dot -Tpng > output/detailed.png
