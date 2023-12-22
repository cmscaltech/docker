for did in `docker images | grep xcache-server | awk '{print $3}' | uniq`;
do
  docker image rm $did --force;
done
docker build --progress=plain --no-cache -t xcache-server .
