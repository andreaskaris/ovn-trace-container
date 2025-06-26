FROM docker.io/library/golang:1.24
WORKDIR /builddir
RUN git clone https://github.com/andreaskaris/ovnkube-plot.git .
RUN make

FROM registry.fedoraproject.org/fedora-minimal:latest
RUN microdnf install ovn ovn-central ovn-host less tar gzip procps-ng strace graphviz -y
RUN microdnf clean all
RUN mkdir /etc/ovn
RUN mkdir /scripts
RUN mkdir -p /var/log/ovn
RUN mkdir -p /var/run/ovn
COPY normalizedbs.sh /scripts/normalizedbs.sh
COPY convertdbs.sh /scripts/convertdbs.sh
COPY entrypoint.sh /scripts/entrypoint.sh
COPY ovn.sh /usr/bin/ovn.sh
COPY ovnkube-plot.sh /usr/bin/ovnkube-plot.sh
COPY --from=0 /builddir/bin/ovnkube-plot /usr/bin/ovnkube-plot
