TESTNAME=l2tp-01
source /testing/pluto/bin/westlocal.sh

if [ -f /var/run/l2tpd.pid ]; then kill `cat /var/run/l2tpd.pid`; fi

iptables -F INPUT
iptables -F OUTPUT
ipsec setup stop

# confirm that the network is alive
ping -n -c 4 192.0.2.254
telnet east-out 3 | wc -l
# make sure that clear text does not get through
iptables -A INPUT -i eth1 -s 192.1.2.23 -p udp --sport 1701 -j REJECT
iptables -A OUTPUT -o eth1 -d 192.1.2.23 -p udp --dport 1701 -j REJECT

# confirm with a ping to east-in
ping -n -c 4 192.0.2.254
telnet east-out 3 | wc -l

ipsec setup restart
ipsec auto --add west--east-l2tp
ipsec auto --add west--east-pass
/testing/pluto/bin/wait-until-pluto-started
ipsec auto --route west--east-pass
ipsec whack --debug-control --debug-controlmore --debug-parsing --debug-crypt

mount --bind /testing/pluto/l2tp-01 /etc/ppp
l2tpd -c west.l2tpd.conf -D &

ipsec auto --route west--east-l2tp

echo done

