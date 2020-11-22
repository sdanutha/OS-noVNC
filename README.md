``` build : os-novnc ```
```
    >> STEP 1
    docker build -t os-novnc:ubuntu-16.04-cuda-10.2 .
    
    >> STEP 2
    docker tag os-novnc:ubuntu-16.04-cuda-10.2 sdanutha/os-novnc:ubuntu-16.04-cuda-10.2
    
    >> STEP 3
    docker push sdanutha/os-novnc:ubuntu-16.04-cuda-10.2
```

``` run : os-novnc ```
```
    docker run --name=ciracore --restart=always -d \
        -p 6080:6080 \
        -e PASSWORD=ciracore \
        -e SUDO=yes \
        --privileged \
        sdanutha/ciracore-os:ubuntu-16.04-cuda-10.2
```
