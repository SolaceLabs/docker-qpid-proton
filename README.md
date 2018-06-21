# Solace docker-qpid-proton Container
Apache Qpid Proton developer environment in docker.

## DockerHub

Images have been pushed to a [Docker Hub repository](https://hub.docker.com/r/solace/docker-qpid-proton/). 

## Docker Image

Images are outlined in the [images](images) folder.

### Docker Image tags

By default all docker images built or published using `solace/docker-qpid-proton:<tag>`. To change the username from `solace` there are two options:
1. Use the `docker tag` command. 
```sh
docker tag solace/docker-qpid-proton:<tag> <username>/<reponame>:<tag>
```
2. Use the `docker_image.sh` username option. 
```sh
docker_image.sh -u <username> <command>
``` 
See `./docker_image.sh help` for more details.

### Building the Docker image

Build and tag the docker images locally with the [Dockerfile](images/Dockerfile) by using the `docker_image.sh build` command. 

Build steps:
1. clone this repository
1. ```./docker_image.sh build ```

For detailed docker build commands look at the [`build.sh`](scripts/build.sh) script.

### Publishing Docker Images

To publish local docker docker-qpid-proton images to Docker hub use the `docker_image/sh publish` command.

Publish Steps:
1. clone this repository
2. build docker images locally using: `./docker_image.sh [-u <username>] build`
3. publish docker images to docker hub using: `./docker_image.sh [-u <username>] publish`
    > **Note:** `./docker_image.sh publish` publishes too the docker hub Registry Server. The publish command will prompt the user login if the user is not already. 

    > **Attention:**  A docker image publish may fail if the user does not have the privileges to publish to a repository. It is recommended to use the `-u <username>` option for steps 2 and 3 to publish images to Docker Hub repositories that users have access to.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

See the list of [contributors](https://github.com/cjwmorgan-sol-sys/docker-qpid-proton/graphs/contributors) who participated in this project.

## License

This project is licensed under the Apache License, Version 2.0. - See the [LICENSE](LICENSE) file for details.
