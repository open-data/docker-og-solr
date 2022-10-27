# Docker OG Solr

Pre-configured Solr Docker image for Open Government Portal.

Note: These images are not vulnerable to CVE-2021-44228 / Log4J2 as are built on top of [patched upstream Solr images.](https://github.com/docker-solr/docker-solr#readme)

```
docker run --name og-solr -p 8983:8983 -d open-data/docker-og-solr
```

The following versions are available as different image tags:

| Solr version  | Docker tag |
| ------------- | ------------- |
| Solr 8  | open-data/docker-og-solr  |

All these images expose the Solr endpoint at http://localhost:8983/solr/

### Persisting Solr core data

1. Run a container:
   ```
   docker run --name og-solr -p 8983:8983 -d open-data/docker-og-solr
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
   docker run --name og-solr -p 8983:8983 --mount type=bind,source="$(pwd)"/my_solr_data,target=/var/solr/data -d open-data/docker-og-solr
   ```