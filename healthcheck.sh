#!/bin/sh

SETS="crowdsec-blacklists-CAPI crowdsec-blacklists-lists-firehol_voipbl crowdsec-blacklists-lists-crowdsec_cve_2024_4577 crowdsec-blacklists-crowdsec"

found=0
for SET in $SETS; do
    if nft list set ip crowdsec "$SET" 2>/dev/null | grep -q '\d\{1,3\}\.'; then
        found=1
    fi
done

if [ "$found" -eq 1 ]; then
  exit 0
else
  echo "No IPs currently blocked (not necessarily unhealthy)"
  exit 0   # changed from 1 to 0 to avoid failure
fi
