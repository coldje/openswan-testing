: ==== start ====
TESTNAME=interop-ikev2-strongswan-02
source /testing/pluto/bin/eastlocal.sh

/usr/local/strongswan/sbin/ipsec start

/testing/pluto/bin/wait-until-pluto-started
