#!/bin/sh
while :
do
  mysql -u root -e "SELECT VERSION();"
  retVal=$?
  if [ $retVal -eq 1 ]; then
    echo "Error getting database version."
  else
    mysql -u root -Bse "CREATE DATABASE librenms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci";
    mysql -u root -Bse "CREATE USER 'librenms' IDENTIFIED BY '"$MYSQL_PASSWORD"'";
    mysql -u root -Bse "GRANT ALL PRIVILEGES ON librenms.* TO 'librenms'";
    exit 0
  fi
  echo "Sleeping 30seconds as we had an error getting mysql version"
  sleep 30
done
