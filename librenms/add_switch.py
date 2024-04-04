#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Add all devices to librenms based on config file"""
import time
import json
import subprocess

def addDevices():
    """Read the config file and add all devices to LibreNMS"""
    print('Adding devices to LibreNMS')
    filename = "/root/switch.yaml"

    inputDict = {}
    with open(filename, 'r', encoding='utf-8',) as fd:
        inputDict = json.load(fd)
        for devDict in inputDict['snmp']:
            add = True
            for key in ['switch', 'version', 'community']:
                if key not in devDict:
                    print(f"Key {key} not found in {devDict}")
                    add = False
            if not add:
                print(f"Skipping {devDict} as it is missing some keys. see error above")
                continue
            cmd = f"lnms device:add {devDict['switch']} --v{devDict['version']} --community={devDict['community']}"
            try:
                result = subprocess.run(cmd, shell=True, check=True)
                print(f"Result of {cmd} is {result}")
            except subprocess.CalledProcessError as ex:
                print(f"Error while running {cmd}")
                print(f"Error message: {ex}")

if __name__ == "__main__":
    print('Start of ADD Switches to LibreNMS')
    while True:
        addDevices()
        print('Sleeping for 1 hour for adding devices again')
        time.sleep(3600)
