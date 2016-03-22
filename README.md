docker run \
	  -v /root/docker/openldap/certs:/etc/openldap/remotecerts 
	  -e PATHENV="/etc/openldap/remotecerts/" \
	  -e PASSWORDENV=my_secret \
          -e IPENV=my_IP \
          -e CERTENV=my_cert \
          -e CERTKEYENV=my_privatekey_cert \
          -e ROOTDNENV=my_rootdn \
	  -p 389:389 \
          -p 636:636 \
	  -ti \
	  --rm \
          --privileged \
	  santinoncs/openldap-to-ad-proxy \
	 /bin/bash
