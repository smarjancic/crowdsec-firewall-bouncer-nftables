#!/bin/sh

# List of blacklist sets to check
SETS="crowdsec-blacklists-CAPI crowdsec-blacklists-lists-firehol_voipbl crowdsec-blacklists-lists-crowdsec_cve_2024_4577 crowdsec-blacklists-crowdsec"

for SET in $SETS; do
    if nft list set ip crowdsec "$SET" 2>/dev/null | grep -q '\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}'; then
        exit 0  # Healthy if any set has at least one IP
    fi
done

echo "No blocked IPs in any monitored sets"
exit 1
