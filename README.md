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
curl -d@sample.csv http://localhost:8080/api/spray
```

you will see it appear in ECL Watch as `messages::in::csv` (note that while it is a CSV, if you're doing it via curl, it might come out as a single line).

## Things to do

* Make the name dynamic, in case you spray more than once...
* Configure a despray workflow.
* Do other funky things like download something from S3 before spraying it.
