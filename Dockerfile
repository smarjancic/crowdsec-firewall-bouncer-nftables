FROM debian:stable-slim

RUN apt update \
    && apt install curl -y \
    && curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | bash \
    && apt install crowdsec-firewall-bouncer-nftables -y \
    && rm -rf /var/lib/apt/lists/* 

ENTRYPOINT crowdsec-firewall-bouncer -c /crowdsec-firewall-bouncer.yaml