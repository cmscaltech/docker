
# Disable autoconf.
sysctl -w net.ipv6.conf.default.autoconf=0

# 2605:d9c0:2:fff0::2/64
export ID=0
export END=2
# echo /etc/iproute2/rt_tables new macvlan….
ip link del macvlan$ID
ip link add link macvlan$ID link enp143s0.43 type macvlan mode bridge
ip link set macvlan$ID up
ip -6 addr add 2605:d9c0:2:fff$ID::$END/64 dev macvlan$ID
ip -6 r add 2605:d9c0:2:fff$ID::$END dev macvlan$ID table macvlan$ID
while true; do ping6 -c2 2605:d9c0:2:fff$ID::1 -I macvlan$ID > /dev/null && break; done
ip -6 route add default via 2605:d9c0:2:fff$ID::1 dev macvlan$ID table macvlan$ID
ip -6 rule add from 2605:d9c0:2:fff$ID::$END/128 table macvlan$ID
ip -6 rule add to 2605:d9c0:2:fff$ID::$END/128 table macvlan$ID


# 2605:d9c0:2:fff1::2/64
export ID=1
export END=2
# echo /etc/iproute2/rt_tables new macvlan….
ip link del macvlan$ID
ip link add link macvlan$ID link enp143s0.43 type macvlan mode bridge
ip link set macvlan$ID up
ip -6 addr add 2605:d9c0:2:fff$ID::$END/64 dev macvlan$ID
ip -6 r add 2605:d9c0:2:fff$ID::$END dev macvlan$ID table macvlan$ID
while true; do ping6 -c2 2605:d9c0:2:fff$ID::1 -I macvlan$ID > /dev/null && break; done
ip -6 route add default via 2605:d9c0:2:fff$ID::1 dev macvlan$ID table macvlan$ID
ip -6 rule add from 2605:d9c0:2:fff$ID::$END/128 table macvlan$ID
ip -6 rule add to 2605:d9c0:2:fff$ID::$END/128 table macvlan$ID


# 2605:d9c0:2:fff2::2/64
export ID=2
export END=2
# echo /etc/iproute2/rt_tables new macvlan….
ip link del macvlan$ID
ip link add link macvlan$ID link enp143s0.43 type macvlan mode bridge
ip link set macvlan$ID up
ip -6 addr add 2605:d9c0:2:fff$ID::$END/64 dev macvlan$ID
ip -6 r add 2605:d9c0:2:fff$ID::$END dev macvlan$ID table macvlan$ID
while true; do ping6 -c2 2605:d9c0:2:fff$ID::1 -I macvlan$ID > /dev/null && break; done
ip -6 route add default via 2605:d9c0:2:fff$ID::1 dev macvlan$ID table macvlan$ID
ip -6 rule add from 2605:d9c0:2:fff$ID::$END/128 table macvlan$ID
ip -6 rule add to 2605:d9c0:2:fff$ID::$END/128 table macvlan$ID



# 2605:d9c0:2:fff3::2/64
export ID=3
export END=2
# echo /etc/iproute2/rt_tables new macvlan….
ip link del macvlan$ID
ip link add link macvlan$ID link enp143s0.43 type macvlan mode bridge
ip link set macvlan$ID up
ip -6 addr add 2605:d9c0:2:fff$ID::$END/64 dev macvlan$ID
ip -6 r add 2605:d9c0:2:fff$ID::$END dev macvlan$ID table macvlan$ID
while true; do ping6 -c2 2605:d9c0:2:fff$ID::1 -I macvlan$ID > /dev/null && break; done
ip -6 route add default via 2605:d9c0:2:fff$ID::1 dev macvlan$ID table macvlan$ID
ip -6 rule add from 2605:d9c0:2:fff$ID::$END/128 table macvlan$ID
ip -6 rule add to 2605:d9c0:2:fff$ID::$END/128 table macvlan$ID

