#!/bin/bash

: ${OSG_TOKEN_RENEWER_ACCOUNT_NAME:="cit-t2"}
: ${OSG_TOKEN_RENEWER_ACCOUNT_PASSWORD:=''}
: ${OSG_TOKEN_RENEWER_TOKEN_URL:="https://lw-issuer.osgdev.chtc.io/scitokens-server/"}

prepare_osg_token_renewer () {

echo ${OSG_TOKEN_RENEWER_TOKEN_URL} ${OSG_TOKEN_RENEWER_TOKEN_URL} > /etc/oidc-agent/issuer.config

# arm cron
echo "*/15 * * * * root /usr/bin/test -f /var/spool/osg-token-svc/.oidc-agent/${OSG_TOKEN_RENEWER_ACCOUNT_NAME} && /usr/bin/supervisorctl start osg-token-renewer" > etc/cron.d/osg-token-renewer

# create password, renewal need read access to it
# if set, force its value
if [ ! -z $OSG_TOKEN_RENEWER_ACCOUNT_PASSWORD ]; then
  echo ${OSG_TOKEN_RENEWER_ACCOUNT_PASSWORD} > /etc/osg/tokens/${OSG_TOKEN_RENEWER_ACCOUNT_NAME}.pw
else
  # if not set in variable generate random
  if [ -z $OSG_TOKEN_RENEWER_ACCOUNT_PASSWORD ] && [ ! -f  /etc/osg/tokens/${OSG_TOKEN_RENEWER_ACCOUNT_NAME}.pw ]; then
    /usr/bin/date +%s | /usr/bin/sha256sum | /usr/bin/base64 | /usr/bin/head -c 32 > /etc/osg/tokens/${OSG_TOKEN_RENEWER_ACCOUNT_NAME}.pw
  fi
fi
chown root:osg-token-svc /etc/osg/tokens /etc/osg/tokens/${OSG_TOKEN_RENEWER_ACCOUNT_NAME}.pw
chmod 750 /etc/osg/tokens
chmod 640 /etc/osg/tokens/${OSG_TOKEN_RENEWER_ACCOUNT_NAME}.pw

# precreate renewer working directory with correct permissions
mkdir -p /var/spool/osg-token-svc/.oidc-agent
chown -R osg-token-svc:osg-token-svc /var/spool/osg-token-svc
chmod 700 /var/spool/osg-token-svc /var/spool/osg-token-svc/.oidc-agent

# create file that instruct what URL to use for renewals
# default is https://lw-issuer.osgdev.chtc.io/scitokens-server/
# see https://osg-htc.org/docs/data/xrootd/install-shoveler/
cat <<EOF > /var/spool/osg-token-svc/.oidc-agent/issuer.config
${OSG_TOKEN_RENEWER_TOKEN_URL} ${OSG_TOKEN_RENEWER_ACCOUNT_NAME}
EOF

# tell renewer what account to use and what token to update
cat <<EOF > /etc/osg/token-renewer/config.ini
[account ${OSG_TOKEN_RENEWER_ACCOUNT_NAME}]
password_file = /etc/osg/tokens/${OSG_TOKEN_RENEWER_ACCOUNT_NAME}.pw

[token ${OSG_TOKEN_RENEWER_ACCOUNT_NAME}-xrootd-monitoring-shoveler]
account = ${OSG_TOKEN_RENEWER_ACCOUNT_NAME}
token_path = /etc/xrootd-monitoring-shoveler/token
EOF

}

prepare_osg_token_renewer

