import json
import pprint
import subprocess


filename="/root/switch.yaml"

inputDict = {}
with open(filename, 'r') as f:
    inputDict = json.load(f)
    for ip_addr_details in inputDict['snmp']:
        cmd = f"lnms device:add {ip_addr_details['switch']}--v2c --community=mgmt_hep"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, check=True)
