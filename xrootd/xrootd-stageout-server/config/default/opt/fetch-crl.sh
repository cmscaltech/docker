#!/bin/sh
rm -f /tmp/fetch-crl-done
while :
do
  echo "Fetching CRLs..." `date`
  /usr/sbin/fetch-crl -p 5 -r 360 -T 10 > /var/log/fetch-crl 2>&1
  touch /tmp/fetch-crl-done
  echo "Done Fetching CRLs. Sleeping for 4hrs"
  sleep 14400
  rm -f /tmp/fetch-crl-done
done 
