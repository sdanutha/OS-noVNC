``` cmd : build ```
```
    docker build -t os-novnc \
        --build-arg IMAGE=nvidia/cuda:10.2-runtime-ubuntu16.04 .
```

``` cmd run ```
```
    docker run -d --name=on-vnc --restart=always \
        -p 6080:6080 \
        -e PASSWORD=ubuntu \
        -e SUDO=yes \
        --privileged os-novnc
```
