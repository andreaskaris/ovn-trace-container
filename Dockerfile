FROM registry.fedoraproject.org/fedora:latest
RUN yum install ovn ovn-central ovn-host -y
RUN mkdir /etc/ovn
RUN mkdir /scripts
RUN mkdir -p /var/log/ovn
RUN mkdir -p /var/run/ovn
COPY entrypoint.sh /scripts/entrypoint.sh
ENTRYPOINT /scripts/entrypoint.sh
