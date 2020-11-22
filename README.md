``` cmd : build ```
```
    docker build -t os-novnc .
```

``` cmd run ```
```
    docker run -d --name=on-vnc --restart=always \
        -p 6080:6080 \
        -e PASSWORD=sdanutha \
        -e SUDO=yes \
        --privileged os-novnc
```
