``` build : ciracore-os ```
```
    
    >> STEP 1
    docker build -t ciracore-os:ubuntu-16.04-cuda-10.2 -f Dockerfile .
    
    >> STEP 2
    docker tag ciracore-os:ubuntu-16.04-cuda-10.2 sdanutha/ciracore-os:ubuntu-16.04-cuda-10.2
    
    >> STEP 3
    docker push sdanutha/ciracore-os:ubuntu-16.04-cuda-10.2

```

``` run : ciracore-os ```
```
    
    docker run --name=ciracore --restart=always -itd \
        -p $PORT:6080 \
        -v $PATH:/home/ciracore/mount \
        -w /home/ciracore \
        -e SUDO=yes \
        -e PASSWORD=ciracore --privileged \
        sdanutha/ciracore-os:ubuntu-16.04-cuda-10.2

```

``` install ciracore ```
```
    
    >> STEP 1
    sudo apt-get update
    sudo apt-get install -y expect
    
    >> STEP 2
    wget https://git.cira-lab.com/cira/cira-core/-/archive/master/cira-core-master.zip
    unzip cira-core-master.zip
    
    >> STEP 3
    cd cira-core-master
    python install.py ciracore

```

``` commit version ```
```
    
    >> STEP 1
    docker commit $CONTAINER_ID sdanutha/ciracore:$CIRACORE_VER
    
    >> STEP 2
    docker push sdanutha/ciracore:$CIRACORE_VER

```
