source ../../environment

if [[ "$HOSTNAME" =~ ^xrd-nvme- ]]; then
  python3 nodeScan.py --memory-percent=35
else
  python3 nodeScan.py
fi

if [[ "$HOSTNAME" =~ ^xrd-cache- ]]; then
  docker-compose up --detach xcache-server xrootd-clustered-server
else
  docker-compose up --detach xcache-server
fi
