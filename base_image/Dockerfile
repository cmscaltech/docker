FROM opensciencegrid/software-base:25-al9-release

RUN yum -y install python3-pyyaml && yum clean all
RUN mkdir -p /opt/usergroups && mkdir -p /opt/scripts/
ADD config/opt/usergroups/user-group /opt/usergroups/user-group
ADD config/opt/scripts/usergroupchecker.py /opt/scripts/usergroupchecker.py
RUN chmod +x /opt/scripts/usergroupchecker.py
ADD config/etc/supervisord.d/10-usergroupchecker.conf /etc/supervisord.d/10-usergroupchecker.conf

