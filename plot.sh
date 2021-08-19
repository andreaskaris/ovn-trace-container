#!/bin/bash

if ! [ -d output ];then 
	mkdir output
fi
podman exec -it ovn /bin/bash -c "/scripts/ovnkube-plot --nb-address=tcp://localhost:9641 2>/dev/null" > output/plot.txt
cat output/plot.txt | dot -Tpdf > output/plot.pdf
cat output/plot.txt | dot -Tsvg > output/plot.svg
cat output/plot.txt | dot -Tpng > output/plot.png
