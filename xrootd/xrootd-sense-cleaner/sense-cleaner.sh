#!/bin/bash
# It will execute deletion of all files under /storage/cms/store/temp
# if SENSE_CLEANUP variable is set
while :
do
    if test "${SENSE_CLEANUP+x}"; then
        echo "[Cleaner] Cleaning UP /storage/cms/store/temp/* files older than 1 minute files"
        find /storage/cms/store/temp/* -type f -mmin +1 -exec rm -f {} \;
    else
        echo "[Cleaner] No SENSE_CLEANUP Flag set. Exit and will not do anything"
        exit 0
    fi
    echo "[Cleaner] Sleep 5 seconds before next loop"
    sleep 5
done
