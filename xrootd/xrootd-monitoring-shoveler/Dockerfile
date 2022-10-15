FROM opensciencegrid/software-base:3.6-el8-release

ARG UNAME=xrootd
ARG UID=2010
ARG GID=2010
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

RUN yum -y install xrootd-monitoring-shoveler osg-token-renewer

# install scripts into /etc/osg/image-init.d
# content executed by 'opensciencegrid/software-base' on startup before supervisord start services
# they will create configuration files based on vars and do other last minute adjastments
ADD Dockerfile.files/etc/osg/image-init.d/*.sh /etc/osg/image-init.d/
# set all file installed above executable permission
RUN chmod +x /etc/osg/image-init.d/*.sh

# install supervisor services shoveler and renewer
ADD Dockerfile.files/etc/supervisord.d/*.conf /etc/supervisord.d/

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
