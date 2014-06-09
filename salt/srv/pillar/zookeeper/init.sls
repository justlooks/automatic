maxcliconns: 500
ticktime: 2000
initlimit: 10
synclimit: 5
datadir: /var/lib/zookeeper
clientport: 2181
snapretaincnt: 3
purgeintervalhour: 1

cluster:
  - 0:192.168.10.235
  - 1:192.168.10.236
  - 2:192.168.10.237

interface: eth0
