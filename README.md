# interlok-hpcc-docker

Uses the HPCC 7.2.14 image, along with the latest-hpcc interlok image, overlays some additional jars on top. The configuration contains a

* Channel that
   * Accepts HTTP POST request, and uploads that data as a new file in the configured S3 bucket under a unique-name
   * Accepts HTTP DELETE request that deletes the associated file.
* Channel that
   * Accepts a HTTP POST request (the payload should be output from the s3-upload); downloads that file from S3 and sprays it into HPCC;
   * Accepts a GET request for a file, and returns a 501 (you could fill this in with a desprayer)

## Quickstart

Create a file __src/main/interlok/config/variables-local.properties.hostname__; where hostname is the name of your machine; you can use `variables-local.properties` if you wish, but the *hostname* variant is auto excluded in the git ignore (so you won't check your secret keys in!)

* On Windows that will be the value of COMPUTERNAME environment variable
* On Linux that will be the HOSTNAME env variarable
* On Mac; the HOSTNAME environment variable isn't always defined...

This is where you'll store all your secret keys...

```
amazon.access.key=My_Access_Key
amazon.secret.key=My_Secret_Key
amazon.region=The region you created the bucket
amazon.s3.bucket=the target bucket name
```

Then after that you can

```
# Build the docker image and effectively runs `docker-compose up -d`
$ ./gradlew docker dockerComposeUp
```

* Connect to http://localhost:8080 and you'll see Interlok
* Connect to http://localhost:8010 and you'll see ECL Watch

```
# Upload a simple CSV to S3.
$ curl -XPOST -d'1,2,3,4' http://localhost:8080/api/aws/s3/upload
{"filename":"4c11cf3c87d04ee6ac67d5c41f0b0f3b", "bucket":"zzlc-s3-bucket"}

# Take the output of the previous operation, and spray into hpcc
$ curl -XPOST -d'{"filename":"4c11cf3c87d04ee6ac67d5c41f0b0f3b", "bucket":"zzlc-s3-bucket"}' http://localhost:8080/api/hpcc/s3-to-hpcc
{"operation":"success"}

# Delete the file from S3...
$ curl -XDELETE http://localhost:8080/api/aws/s3/zzlc-s3-bucket/4c11cf3c87d04ee6ac67d5c41f0b0f3b
{"operation":"success"}

## Attempt to despray it (not yet implemented, so 501 is expected)
$ curl -i -XGET http://localhost:8080/api/hpcc/despray/4c11cf3c87d04ee6ac67d5c41f0b0f3b
HTTP/1.1 501 Not Implemented
Content-Type: application/json
Transfer-Encoding: chunked
Server: Jetty(9.4.15.v20190215)

{"failure": "not-yet-implemented"}


```


## Things to do

* Refactor to use shared-services; since the pair that adds 200 OK + `{"operation":"success"}` should just be a shared-service.
* Fill in the "GET" branch in the api/spray channel that despray so we don't get a 501 error anymore.
* Switch to using the new _switch_ service once 3.9 is available.

