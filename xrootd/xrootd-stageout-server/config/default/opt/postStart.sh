#!/bin/bash
# PostStart script will copy and change ownership of the XRootD certificates and macaroon secret
# as xrootd expects it to be owned by xrootd user.

mkdir -p /etc/grid-security/xrootd/

cp /etc/grid-security/xrootdkey.pem /etc/grid-security/xrootd/

# check if 4th cert is COMODO SHA1 signed root
openssl storeutl --noout --text --certs /etc/grid-security/xrootdcert.pem | grep "Subject: C=GB, ST=Greater Manchester, L=Salford, O=Comodo CA Limited, CN=AAA Certificate Services"
if [ $? -eq 0 ]; then
  # if AAA Certificate Services remove it (keeps only 3)
  ( openssl x509; openssl x509 ; openssl x509 ) < /etc/grid-security/xrootdcert.pem > /etc/grid-security/xrootd/xrootdcert.pem
else
  cp /etc/grid-security/xrootdcert.pem /etc/grid-security/xrootd/xrootdcert.pem
fi

chown -R xrootd:xrootd /etc/grid-security/xrootd/

cp /tmp/macaroon-secret /etc/xrootd/macaroon-secret
chown xrootd:xrootd /etc/xrootd/macaroon-secret
