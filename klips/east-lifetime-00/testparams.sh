#!/bin/sh

TEST_TYPE=klipstest
TESTNAME=east-lifetime-00
TESTHOST=east
EXITONEMPTY=--exitonempty

REF_PUB_OUTPUT=../east-icmp-01/spi1-output.txt
PUBLIC_ARPREPLY=true

PRIV_INPUT=../inputs/01-sunrise-sunset-ping.pcap

REF_CONSOLE_OUTPUT=test-00-console.txt
REF_CONSOLE_FIXUPS="kern-list-fixups.sed nocr.sed"
REF_CONSOLE_FIXUPS="$REF_CONSOLE_FIXUPS klips-spi-sanitize.sed"
REF_CONSOLE_FIXUPS="$REF_CONSOLE_FIXUPS klips-debug-sanitize.sed"
REF_CONSOLE_FIXUPS="$REF_CONSOLE_FIXUPS ipsec-look-sanitize.sed"

TCPDUMPFLAGS="-n -E 3des-cbc-hmac96:0x4043434545464649494a4a4c4c4f4f515152525454575758"
SCRIPT=test01.sh




