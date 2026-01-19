# Everything's fine but delay coming -- check network delay and limits
tc -s qdisc show dev eth0

# For Chaos experiment, add limit by yourself
tc qdisc add dev eth0 root netem delay 500ms

# Delete this rule to make it fast again
tc qdisc del dev eth0 root
