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
1. Visit http://localhost:8020/

# Without docker

To be disclosed in unknown future.


# Editing the documentation

When you have `grav` up and running it will automatically serve `*.md` files located in `pages` directory. After 
saving changes to `.md` file simply reload your browser to see the changes take effect.

Final documentation content should be committed to the repository.
