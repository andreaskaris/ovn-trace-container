#!/bin/bash

FILTER="$1"

if ! [ -d output ];then 
	mkdir output
fi
podman exec -it ovn /bin/bash -c "/scripts/ovnkube-plot --filter="$FILTER" --nb-address=tcp://localhost:9641 2>/dev/null" > output/compact.txt
cat output/compact.txt | dot -Tpdf > output/compact.pdf
cat output/compact.txt | dot -Tsvg > output/compact.svg
cat output/compact.txt | dot -Tpng > output/compact.png

podman exec -it ovn /bin/bash -c "/scripts/ovnkube-plot --format=legacy --nb-address=tcp://localhost:9641 2>/dev/null" > output/legacy.txt
cat output/legacy.txt | dot -Tpdf > output/legacy.pdf
cat output/legacy.txt | dot -Tsvg > output/legacy.svg
cat output/legacy.txt | dot -Tpng > output/legacy.png
