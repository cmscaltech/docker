#!/bin/bash

: ${OSG_TOKEN_RENEWER_ACCOUNT_PASSWORD:=''}

prepare_osg_token_renewer () {

# create password, renewal need read access to it
# if set, force its value
if [ ! -z $OSG_TOKEN_RENEWER_ACCOUNT_PASSWORD ]; then
  echo ${OSG_TOKEN_RENEWER_ACCOUNT_PASSWORD} > /etc/osg/tokens/renewer.pw
else
  # if not set in variable generate random
  if [ -z $OSG_TOKEN_RENEWER_ACCOUNT_PASSWORD ] && [ ! -f  /etc/osg/tokens/renewer.pw ]; then
    /usr/bin/date +%s | /usr/bin/sha256sum | /usr/bin/base64 | /usr/bin/head -c 32 > /etc/osg/tokens/renewer.pw
  fi
fi
chown root:osg-token-svc /etc/osg/tokens /etc/osg/tokens/renewer.pw
chmod 750 /etc/osg/tokens
chmod 640 /etc/osg/tokens/renewer.pw

}

prepare_osg_token_renewer

