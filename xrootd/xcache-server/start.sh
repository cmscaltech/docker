source ../../environment
python3 nodeScan.py
if [[ $HOSTNAME == *"nvme"* ]]; then
  docker compose up --detach xcache-server
else
  docker compose up --detach
fi
