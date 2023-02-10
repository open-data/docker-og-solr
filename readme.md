# Docker OG Solr

Pre-configured Solr Docker image for Open Government Portal.

Docker Image: https://hub.docker.com/r/opendatacanada/solr

Note: These images are not vulnerable to __CVE-2021-44228 / Log4J2__ as are built on top of [patched upstream Solr images.](https://github.com/apache/solr-docker#readme)

```
docker run --name og-solr -p 8983:8983 -d opendatacanada/solr
```

The following versions are available as different image tags:

| Solr version  | Docker tag |
| ------------- | ------------- |
| Solr 8  | opendatacanada/solr  |

All these images expose the Solr endpoint at http://localhost:8983/solr/

### Persisting Solr core data

1. Run a container:
   ```
   docker run --name og-solr -p 8983:8983 -d opendatacanada/solr
   ```

2. Copy the Solr data directory of the target core to your machine:
   ```
   docker cp og-solr:/var/solr/data ./my_solr_data
   ```

3. Stop the container:
   ```
   docker stop og-solr
   ```

4. Run the container with a bind mount:
   ```
   docker run --name og-solr -p 8983:8983 --mount type=bind,source="$(pwd)"/my_solr_data,target=/var/solr/data -d opendatacanada/solr
   ```

### Building for Committing to the Docker Hub

Your docker account will need to be part of the organization `opendatacanada`

1. Log into the docker hub (this is only required once):
   ```
   docker login
   ```

2. Build the image:
   ```
   docker build ./
   ```

3. Run the new docker image with the hash from the end of the previous command output:
   ```
   docker run -d sha256:<image hash>
   ```

4. Get the container ID:
   ```
   docker ps
   ```

5. Commit the build:
   ```
   docker commit <container ID> opendatacanada/solr
   ```

6. Push the build to the docker hub:
   ```
   docker push opendatacanada/solr
   ```