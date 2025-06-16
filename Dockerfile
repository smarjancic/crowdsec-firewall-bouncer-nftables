FROM debian:stable-slim

RUN apt update \
    && apt install curl -y \
    && curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | bash \
    && apt install crowdsec-firewall-bouncer-nftables -y \
    && rm -rf /var/lib/apt/lists/* 

COPY healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh
    
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD ["/usr/local/bin/healthcheck.sh"]    

ENTRYPOINT crowdsec-firewall-bouncer -c /crowdsec-firewall-bouncer.yaml