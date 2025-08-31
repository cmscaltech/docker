source ../environment
docker login
dockerimageid=`docker images | grep hepgui | grep latest | awk '{print $3}'`
docker tag $dockerimageid cmscaltech/hepgui:latest
docker push cmscaltech/hepgui
