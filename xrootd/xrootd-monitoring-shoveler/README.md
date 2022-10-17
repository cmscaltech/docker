## How to run container

### to start use
```
docker compose down ; docker-compose build --no-cache;  docker compose up -d
```
or
```
docker compose down
docker-compose build --no-cache
docker compose up -d
```

### to initialize renewal for token used by shoveler run inside container
```
xrootd-monitoring-shoveler-token-renewer-setup
```

or from outside use
```
docker exec -it xrootd-monitoring-shoveler xrootd-monitoring-shoveler-token-renewer-setup
```


### quickly enter container
```
docker exec -it xrootd-monitoring-shoveler bash
```

Note: We may want to remove osg-token-renewer service and use a simple cron to run it

### Logs

Not sure how better to redirect logs, i've tried to redirect daemons logs to STDIN. 
It appear in docker logs, but some missing timemark and it looks complete mess. 
```
docker logs xrootd-monitoring-shoveler
```
