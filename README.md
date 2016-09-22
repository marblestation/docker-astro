
# Docker container with astronomical tools

This container provides a linux environment with spectroscopic and photometric tools (among other non-astronomical tools). It does not include [iSpec](http://www.blancocuaresma.com/s/), but it can be run from within the container.

## Build the image

```bash
docker build -t marblestation/astro .
```

By default, there will be a user created named 'docker'. But the user name can be changed:

```bash
docker build --build-arg USERNAME=john -t marblestation/astro .
```

### Selective cache layers:

1. Include the following command in the Dockerfile from the point where layers should be ignored if they are in the cache (i.e., force execution):
```
ARG CACHEBUST=1
```
2. Build as:
```bash
docker build -t marblestation/astro --build-arg CACHEBUST=$(date +%s) .
```

## Run the image

### OS X

1. Install [XQuartz](https://www.xquartz.org/) [minimum 2.7.10_beta2](https://www.xquartz.org/releases/XQuartz-2.7.10_beta2.html) (previous version contain a bug)
2. Open XQuartz: open -a XQuartz
    1. Update preferences 'Security' tab - turn on 'Allow connection from network clients'
    2. Restart XQuartz and then check to see that it is listening on port 6000: lsof -i :6000

3. Add to the end of '$HOME/.bashrc':
```bash
# Start container based on the astro image
docker_astro_container() {
    GITNAME="Sergi Blanco-Cuaresma"
    GITEMAIL="marblestation@users.noreply.github.com"
    DOCKER_USERNAME="docker"

    DOCKER_IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
    xhost + $DOCKER_IP

    docker run -it --rm \
            --detach-keys="ctrl-q,q" \
            --device /dev/fuse --cap-add SYS_ADMIN \
            -e DISPLAY=$DOCKER_IP:0 \
            -e GITEMAIL="$GITEMAIL" -e GITNAME="$GITNAME" \
            -v $HOME:/home/$DOCKER_USERNAME/workspace \
            -v ${HOME}/.ssh/id_rsa:/home/$DOCKER_USERNAME/.ssh/id_rsa:ro \
            -v $HOME/astrometry_index_4200:/opt/astrometry_catalogue:ro \
            -v $HOME/ePipe:/home/$DOCKER_USERNAME/ePipe:ro \
            -v $HOME/iSpec:/home/$DOCKER_USERNAME/iSpec:ro \
            marblestation/astro
            #-p 127.0.0.1:8888:8888 \
}

# Kill all running containers.
alias docker_killall='printf "\n>>> Killing all containers\n\n" && docker kill $(docker ps -q)'

# Stop all running containers.
alias docker_stopall='printf "\n>>> Stoping all containers\n\n" && docker stop $(docker ps -q)'

# List all containers and images.
alias docker_listall='printf "\n>>> List all containers\n\n" && docker ps -a && printf "\n>>> List all containers\n\n" && docker images'

# Delete all stopped containers.
alias docker_clean_containers='printf "\n>>> Deleting stopped containers\n\n" && docker rm -v $(docker ps -a -q -f status=exited)'

# Delete all untagged images.
alias docker_clean_images='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias docker_clean='docker_clean_containers || true && docker_clean_images'
```
4. Load the new configuration:
```
source $HOME/.bashrc
```
5. Run the image:
```
docker_astro_container
```

**NOTE:** If we want to use jupyter notebook, the container should be run with '-p 127.0.0.1:8888:8888' and, once inside, execute: 

```bash
jupyter notebook --ip=*
```

## Docker Hub

### Pull the image

```bash
docker pull marblestation/astro:latest
```
