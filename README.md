# interlok-hpcc-docker

Uses the HPCC 7.2.14 image, along with the latest-hpcc interlok image, overlays some additional jars on top


## Quickstart

```
./gradlew docker
docker-compose up
```

* Connect to http://localhost:8080 and you'll see Interlok
* Connect to http://localhost:8010 and you'll see ECL Watch

```
curl -d'1,2,3,4' http://localhost:8080/api/spray
```

you will see it appear in ECL Watch as `messages::in::csv`

## Things to do

* Make the name metadata driven; from your URL.
* Make the name dynamic, in case you spray more than once...
* Configure a despray workflow.
* Do other funky things like download something from S3 before spraying it.
