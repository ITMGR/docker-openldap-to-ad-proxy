FROM centos:centos6

MAINTAINER santiago <santiago.nunezcacho@softonic.com>

RUN yum install openldap openldap-clients openldap-servers -y

EXPOSE 389 636

COPY config /opt/docker/config

COPY schema /opt/docker/schema

COPY scripts /opt/docker/scripts

#COPY certs/SoftonicCAroot.pem /etc/pki/ca-trust/source/anchors/

WORKDIR /opt/docker/scripts

ENTRYPOINT ["/opt/docker/scripts/start.sh"]
