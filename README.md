# How to use this image

## start a rethinkdb instance

`docker run -d --name rethinkdb -p 8080:8080 -p 28015:28015 -p 29015:29015 -v /some/dir:/data graanjonlo/rethinkdb`

This image includes `EXPOSE 8080`, `28015` and `29015`, so standard container linking will make it automatically available to the linked containers. It also includes `VOLUME ["/data"]` so you can mount data volumes.

