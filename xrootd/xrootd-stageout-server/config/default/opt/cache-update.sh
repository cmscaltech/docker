#!/bin/bash
# This script is used to update the XCache proxy every 10 minutes
if [ -z "$X509_USER_PROXY" ]; then
  echo "X509_USER_PROXY is not set. Exiting..."
  exit 1
fi
if [ -z "$K8S_X509_USER_PROXY" ]; then
  echo "K8S_X509_USER_PROXY is not set. Exiting..."
  exit 1
fi
while :
do
  if cmp --silent -- "$X509_USER_PROXY" "$K8S_X509_USER_PROXY"; then
    echo "XCache Proxy is same. No need to update. sleep 10mins"
  else
    echo "XCache proxy was updated. Updating X509..."
    cp $K8S_X509_USER_PROXY $X509_USER_PROXY
    chown xrootd:xrootd $X509_USER_PROXY
    chmod 600 $X509_USER_PROXY
    echo "New Proxy details:"
    voms-proxy-info -all
    echo "Update done. Sleep 10 mins"
  fi
  sleep 600
done
