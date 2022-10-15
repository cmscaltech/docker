#!/bin/bash

: ${AMQP_URL:="amqps://clever-turkey.rmq.cloudamqp.com/xrd-mon"}
: ${AMQP_EXCHANGE:="shoveled-xrd"}
: ${AMQP_TOPIC:=""}
: ${AMQP_TOKEN_LOCATION:="/etc/xrootd-monitoring-shoveler/token"}

: ${LISTEN_PORT:="9993"}
: ${LISTEN_IP:="0.0.0.0"}

# Whether to verify the header of the packet matches XRootD's monitoring
# packet format
: ${VERIFY:="true"}

# Export prometheus metrics
: ${METRICS_ENABLE:="true"}
: ${METRICS_PORT:=""}

# Directory to store overflow of queue onto disk.
: ${OVERFLOW_DIRECTORY:="/var/spool/shoveler-queue"}

prepare_shoveler_server () {
cat <<EOF > /etc/xrootd-monitoring-shoveler/config.yaml
amqp:
  url: ${AMQP_URL}
  exchange: ${AMQP_EXCHANGE}
  topic: ${AMQP_TOPIC}
  token_location: ${AMQP_URL_TOKEN_LOACATION}

listen:
  port: ${LISTEN_PORT}
  ip: ${LISTEN_IP}

# Where to foward udp messages, if necessary
# Multiple destinations supported
#outputs:
#  destinations:
#    - 127.0.0.1:1234

# Whether to verify the header of the packet matches XRootD's monitoring
# packet format
verify: ${VERIFY}

# Export prometheus metrics
metrics:
  enable: ${METRICS_ENABLE}
  port: ${METRICS_PORT}

# Directory to store overflow of queue onto disk.
# The queue keeps 100 messages in memory.  If the shoveler is disconnected from the message bus,
# it will store messages over the 100 in memory onto disk into this directory.  Once the connection has been re-established
# the queue will be emptied.  The queue on disk is persistent between restarts.
queue_directory: ${OVERFLOW_DIRECTORY}

# doc said it should be queue_directory, but default file comes with config_directory

EOF
}

${OVERFLOW_DIRECTORY}

prepare_shoveler_server


