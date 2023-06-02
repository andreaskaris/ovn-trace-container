FROM docker.io/library/golang:1.17
WORKDIR /builddir
RUN git clone https://github.com/andreaskaris/ovnkube-plot.git .
RUN make

FROM registry.fedoraproject.org/fedora:latest
RUN yum install ovn ovn-central ovn-host -y
RUN mkdir /etc/ovn
RUN mkdir /scripts
RUN mkdir -p /var/log/ovn
RUN mkdir -p /var/run/ovn
COPY convertdbs.sh /scripts/convertdbs.sh
COPY entrypoint.sh /scripts/entrypoint.sh
COPY --from=0 /builddir/bin/ovnkube-plot /scripts/ovnkube-plot
