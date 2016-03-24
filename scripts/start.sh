#!/bin/bash


HOSTNAME=$HOSTENV
URLCAEXTRACT=$URLCAEXTRACTENV
CANAME=${CAFILEENV}

D=`dirname $0`/..
SLAPDCONFTEMPLATE=${D}/config/slapd.conf.template
SLAPDCONF=${D}/slapd.conf
SCHEMADIRREL=${D}/schema
SCHEMADIR=`readlink -f $SCHEMADIRREL`

# Generate config files from templates

ROOTDN=$ROOTDNENV
ROOTPW=$PASSWORDENV
IP=$IPENV

sed "s/dc=example,dc=com/$ROOTDN/g;s|__SCHEMADIR__|$SCHEMADIR|g;s/^rootpw.*$/rootpw     $ROOTPW/g;s/^acl-passwd.*$/acl-passwd $ROOTPW/g;s/IP_ACTIVED/$IP/g;s/^TLSCACertificateFile     certificatecafile/TLSCACertificateFile     \/etc\/pki\/ca-trust\/source\/anchors\/$CANAME/g;" ${SLAPDCONFTEMPLATE} >${SLAPDCONF}

cp ${SLAPDCONF} /etc/openldap

curl $URLCAEXTRACT -o /tmp/cafile.pem

cp /tmp/cafile.pem /etc/pki/ca-trust/source/anchors/

update-ca-trust force-enable
update-ca-trust extract
hostname $HOSTNAME

# Setup the LDAP schema
mkdir -p /etc/openldap/slapd.d.new
slaptest -f ${SLAPDCONF} -F /etc/openldap/slapd.d.new
chown ldap:ldap /etc/openldap/slapd.d.new -R
chmod 700 /etc/openldap/slapd.d.new
rm -Rf /etc/openldap/slapd.d
mv /etc/openldap/slapd.d.new /etc/openldap/slapd.d


exec /usr/sbin/slapd -h 'ldap:/// ldapi:/// ldaps:///' -u ldap -d 2
