for did in `docker images | grep hepgui | awk '{print $3}' | uniq`;
do
  docker image rm $did --force;
done
docker build --no-cache -t nomachine --platform=linux/amd64 .
