source ../../environment
python3 nodeScan.py
if [[ "$HOSTNAME" =~ ^xrd-cache- ]]; then
  docker compose up --detach xcache-server xrootd-clustered-server
else
  docker compose up --detach xcache-server
fi
