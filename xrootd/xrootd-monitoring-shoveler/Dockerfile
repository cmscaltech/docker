FROM opensciencegrid/software-base:3.6-el8-release

ARG UNAME=xrootd
ARG UID=2010
ARG GID=2010
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

RUN yum -y install xrootd-monitoring-shoveler osg-token-renewer
RUN yum -y install iputils iproute

# install scripts into /etc/osg/image-init.d
# content executed by 'opensciencegrid/software-base' on startup before supervisord start services
# they will create configuration files based on vars and do other last minute adjastments
ADD Dockerfile.files/etc/osg/image-init.d/*.sh /etc/osg/image-init.d/
# set all file installed above executable permission
RUN chmod +x /etc/osg/image-init.d/*.sh

# install supervisor services shoveler and renewer
ADD Dockerfile.files/etc/supervisord.d/*.conf /etc/supervisord.d/

# install renewer config
ADD Dockerfile.files/etc/osg/token-renewer/config.ini /etc/osg/token-renewer/config.ini

# install cron that will periodically trigger renewer service
RUN echo "*/15 * * * * root /usr/bin/test -f /var/spool/osg-token-svc/.oidc-agent/renewer && /usr/bin/supervisorctl start osg-token-renewer" > /etc/cron.d/osg-token-renewer

# replace list of renewal services with only one used for shoveler https://lw-issuer.osgdev.chtc.io/scitokens-server/
RUN echo "https://lw-issuer.osgdev.chtc.io/scitokens-server/ https://lw-issuer.osgdev.chtc.io/scitokens-server/" > /etc/oidc-agent/issuer.config

# add our own scripts that (re-)init token renewal
ADD Dockerfile.files/usr/sbin/xrootd-monitoring-shoveler-token-renewer-setup /usr/sbin/xrootd-monitoring-shoveler-token-renewer-setup
RUN chmod 755 /usr/sbin/xrootd-monitoring-shoveler-token-renewer-setup

# In original rpm package systemd SETUID SETGID capabilities are used.
# We use suspervisord and need to tweak permissions
# setting permissions on directries won't work 

# allow token service to write shoveler token
RUN chown xrootd:osg-token-svc /etc/xrootd-monitoring-shoveler
RUN chmod                  770 /etc/xrootd-monitoring-shoveler

# allow token service to read account password file
RUN chown root:osg-token-svc /etc/osg/tokens
RUN chmod 750 /etc/osg/tokens

# allow shoveler to write into queue_directory
RUN chown $UNAME:$UNAME /var/spool/shoveler-queue

# precreate renewer working directory with correct permissions
RUN mkdir -p /var/spool/osg-token-svc/.oidc-agent
RUN chown -R osg-token-svc:osg-token-svc /var/spool/osg-token-svc
RUN chmod 700 /var/spool/osg-token-svc /var/spool/osg-token-svc/.oidc-agent

