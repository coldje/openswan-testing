: ==== start ====
TESTNAME=interop-ikev2-strongswan-01
source /testing/pluto/bin/westnlocal.sh

# make sure that clear text does not get through
iptables -A INPUT -i eth1 -s 192.0.2.0/24 -j DROP

ipsec setup start
ipsec whack --whackrecord /var/tmp/ikev2.record
ipsec auto --add westnet--eastnet-ikev2
ipsec auto --status
/testing/pluto/bin/wait-until-pluto-started

echo done

