: ==== start ====
TESTNAME=pluto-aliases-01
source /testing/pluto/bin/eastlocal.sh
ifconfig eth0:0 192.168.99.1
ifconfig eth0:1 172.16.0.1
ipsec setup start
ipsec auto --add westnet-eastnet
ipsec whack --debug-control --debug-controlmore --debug-crypt
/testing/pluto/bin/wait-until-pluto-started
