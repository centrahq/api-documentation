# Docker

1. Create an GitHub access token and make sure you can access `centrahq/centra-grav-themes` repository.
1. Create a `docker-compose.override.yml` file and put obtained access token as `GH_ACCESS_TOKEN` build argument.
1. Build docker image and spin it up:
   ```shell
   docker-compose up
   ```
1. In case of changes in installed plugins, node packages or style changes a rebuild is needed:
   ```shell
   docker-compse up --build
   ```

# Without docker

To be disclosed in unknown future.
