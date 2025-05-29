ARG RELEASE=latest
FROM cmscaltech/base_image:$RELEASE
# NOTES
# 2024 Feb 7th - Move to cmscaltech/base_image (which is based on OSG Image. See base_image repo)

RUN yum -y install xrootd-client gfal2-util-scripts gfal2-all gfal2-python3 python3-gunicorn python3-pyyaml && yum clean all

RUN pip3 install prometheus_client flask

RUN mkdir -p /opt/ && mkdir -p /srv/
ADD config/default/etc/supervisord.d/10-xrootd.conf /etc/supervisord.d/10-xrootd.conf
ADD config/default/opt/xroot-mon.py /opt/xroot-mon.py
ADD config/default/opt/http-server.py /opt/http-server.py

# Get latest CA's
RUN fetch-crl || echo "Supress warnings."

