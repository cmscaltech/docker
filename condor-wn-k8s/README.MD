This image is used for condor jobs. Any job which runs on Tier2, will run inside docker container.

To use this with condor - there are some steps needed to configure condor, for example:
```
DOCKER_VOLUME_DIR_CVMFS         = /cvmfs:/cvmfs:ro,slave
DOCKER_VOLUME_DIR_ETC_CVMFS     = /etc/cvmfs:/etc/cvmfs:ro
DOCKER_VOLUME_DIR_CMS           = /storage/cms:/storage/cms:ro
DOCKER_VOLUME_DIR_AF            = /storage/af:/storage/af:ro
DOCKER_VOLUME_DIR_GRID_SECURITY = /etc/grid-security:/etc/grid-security:ro
DOCKER_VOLUME_DIR_SSSD_PIPES    = /var/lib/sss/pipes
DOCKER_VOLUME_DIR_SSSD_MC       = /var/lib/sss/mc:/var/lib/sss/mc:ro
DOCKER_VOLUME_DIR_NSSWITCH      = /etc/nsswitch.conf:/etc/nsswitch.conf:ro
DOCKER_VOLUME_DIR_DEV_LOG       = /dev/log

DOCKER_MOUNT_VOLUMES = CVMFS, ETC_CVMFS, CMS, AF, GRID_SECURITY, NSSWITCH, DEV_LOG, SSSD_PIPES, SSSD_MC

## Limit CMS Storage mount to CMS VO
DOCKER_VOLUME_DIR_CMS_MOUNT_IF = x509UserProxyVOName =?= "cms"
## Limit AF Storage mount only to local user jobs
DOCKER_VOLUME_DIR_AF_MOUNT_IF = TARGET.InteractiveUser=?=TRUE


# Dropping kernel capabilities (docker run --cap-drop=all) breaks glExec
DOCKER_DROP_ALL_CAPABILITIES = false

# Use wrapper script to add capabilities when running trusted images
# Adding CAP_SYS_ADMIN enables mount() for glExec and Singularity bind mounts
DOCKER = /usr/local/libexec/condor-docker
```
Wrapper script: `/usr/local/libexec/condor-docker` is wrapper to run docker command and point to an image (and or give privileges).
You would use that script to manipulate docker run commands/parameters. We keep it private - due to nature of script exposing some
information, like image registry, docker params and what is allowed to mount, umount and or what privileges we give to containers.
If you are interested in it - please drop an email to hep-wheel@caltech.edu



START = (!isUndefined(Owner)   && Owner=?="jbalcas")
    6  cp /opt/secrets/hostcert /etc/grid-security/hostcert.pem
    7  cp /opt/secrets/hostkey /etc/grid-security/hostkey.pem
    8  ls -l /etc/grid-security/
    9  chmod 600 /etc/grid-security/hostkey.pem
   10  ls -l /etc/grid-security/
   11  cp /opt/secrets/token /etc/condor/tokens.d/condor@ultralight.org
   12  vi /etc/condor/config.d/99-local.conf
   13  condor_master
