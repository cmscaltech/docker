#!/usr/bin/python3
import os
import socket
import json
import yaml
import subprocess
import psutil

compFile = 'docker-compose.yml'
compContent = {}

with open(compFile, 'r') as fd:
    compContent = yaml.safe_load(fd)

process = subprocess.run("lsblk --json -o NAME,MOUNTPOINT".split(), stdout=subprocess.PIPE)
blockdevices = json.loads(process.stdout)

for service in compContent['services'].keys():
    newVolumes = []
    volumes = []
    for item in compContent['services'][service]['volumes']:
        if not item.startswith('/data'):
            newVolumes.append(item)

    for item in blockdevices.get('blockdevices', []):
        if item['mountpoint'] and item['mountpoint'].startswith('/data'):
            #print ('Mountpoint: ' + item['mountpoint'])
            newVolumes.append("%s:%s:rw" % (item['mountpoint'], item['mountpoint']))
            volumes.append(item['mountpoint'])

        for chitem in item.get('children', []):
            if chitem['mountpoint'] and chitem['mountpoint'].startswith('/data'):
                newVolumes.append("%s:%s:rw" % (chitem['mountpoint'], chitem['mountpoint']))
                volumes.append(chitem['mountpoint'])

    compContent['services'][service]['volumes'] = newVolumes

with open(compFile, 'w') as fd:
    yaml.dump(compContent, fd)

xdir = './config/%s/etc/xrootd/config.d' % socket.gethostname().split('.', 1)[0]
os.makedirs(xdir, exist_ok=True)

with open('%s/90-custom.cfg' % xdir, 'w') as fd:
    fd.write('='*40 + '\n')
    fd.write('AUTO DISKS CONFIGURED BY SCRIPT\n')
    fd.write('='*40 + '\n\n')
    for item in volumes:
        print('volume: ' + item)
        if not os.path.isdir('%s/xcache' % item):
            print('Disk %s is ignored as it does not have xcache directory inside' % item)
            continue
        # oss.space data %s/xcache
        fd.write("oss.space data %s/xcache\n" % item)
    fd.write('\n\n')
    fd.write('='*40 + '\n')
    fd.write('AUTO MEMORY FOR XROOTD. 70% of all available mem\n')
    fd.write('='*40 + '\n\n')
    totalMem = int(psutil.virtual_memory().total * 0.7/1024/1024/1204)
    fd.write('pfc.ram %sg' % totalMem)
