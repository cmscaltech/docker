FROM opensciencegrid/frontier-squid:23-release
# NOTES
# 2024 Mar 8th - First deployment. Take OSG Squid and add squid_exporter

RUN mkdir -p /opt && \
    curl -fSL "https://github.com/boynux/squid-exporter/releases/download/v1.11.0/squid-exporter-linux-amd64" -o /opt/squid-exporter && \
    chmod +x /opt/squid-exporter

COPY config/etc/supervisord.d/10-squid-exporter.conf /etc/supervisord.d/10-squid-exporter.conf
