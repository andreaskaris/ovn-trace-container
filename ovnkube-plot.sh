#!/bin/bash

OUTPUT_DIR="/output"
FILTER="$1"

for pid in $(pgrep -f nbdb) $(pgrep -f nb_db); do
    port=$(ss -lntp | grep "pid=${pid}" | awk '{print $4}' | awk -F ':' '{print $NF}')
    name=$(ps -p "${pid}" -o command | grep -P -o "remote=.*? " | awk -F '[./]' '/punix/ {print $(NF-1)}')
    for format in compact detailed; do
        output_file="${OUTPUT_DIR}/${name}_${format}"
        ovnkube-plot \
            --format="${format}" \
            --filter="${FILTER}" \
            --nb-address="tcp://localhost:${port}" > "${output_file}.txt"
        for filetype in pdf svg png; do
            dot -T"${filetype}" < "${output_file}.txt" > "${output_file}.${filetype}"
        done
    done
done
