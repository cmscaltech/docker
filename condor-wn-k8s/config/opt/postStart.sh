#!/usr/bin/env sh
# It will copy cert/key to grid-security and token to condor
# These are needed for authentaication with the HTCondor Collector
cp /opt/secrets/hostcert /etc/grid-security/hostcert.pem
cp /opt/secrets/hostkey /etc/grid-security/hostkey.pem
chmod 600 /etc/grid-security/hostkey.pem
cp /opt/secrets/token /etc/condor/tokens.d/condor@ultralight.org
