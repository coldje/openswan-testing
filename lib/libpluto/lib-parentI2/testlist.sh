(../parentI2 ../lib-parentI1/ikev2.record westnet--eastnet-ikev2 parentR1.pcap 2>&1 | tee secrets.raw
    grep '^\.\./parentI2 ikev2 [IR]' secrets.raw | cut -c13- >ike-secrets.txt
    echo TCPDUMP output
    tcpdump -t -v -v -s 1600 -n -E ike-secrets.txt -r parentI2.pcap ) 2>&1 | sed -f sanity.sed






