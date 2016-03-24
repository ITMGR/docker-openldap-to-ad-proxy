docker run -d \
     -e PASSWORDENV=my_secret \
     -e IPENV=my_IP \
     -e ROOTDNENV=my_rootdn \
     -e HOSTENV=myhostname \
     -e URLCAEXTRACTENV=urltoextractca \
     -e CAFILEENV=myfilecacert
     -p 389:389 \
     -p 636:636 \
     --privileged \
     santinoncs/openldap-to-ad-proxy
