# Sample App
Docker image for ...

### Base Image

- [Alpine:Edge](https://hub.docker.com/_/alpine)
- [influx6:Novnc](https://hub.docker.com/influx6/novnc)


**Example**
```
docker run -d \
    -p 5900:5900 \
    -p 6080:6080 \
    --name=novnc \
    -e DISPLAY_WIDTH=<> \
    -e DISPLAY_HEIGHT=<> \
    -e DISPLAY_DEPTH=<> \
    -e VNC_SERVER=<x11 or tigervnc> (default: tigervnc) \
    -e VNC_PASSWORD=mypassword \
    influx6/app:latest
```

**Access via web interface (noVNC)**

`http://<host ip>:<host port>/vnc.html?resize=remote&host=<host ip>&port=<host port>&&autoconnect=1`

e.g.:-

`http://192.168.1.10:6080/vnc.html?resize=remote&host=192.168.1.10&port=6080&&autoconnect=1`

**Access via VNC client**

`<host ip>::<host port>`

e.g.:-

`192.168.1.10::5900`

**Usage**
```
docker run -d \
    -p 5900:5900 \
    -p 6080:6080 \
    --name=<container name> \
    influx6/app:latest
```

To run with another application, write your own docker file:

```docker-file
FROM influx6/app:latest
RUN \
    # Install xterm
    apk add xterm && \
    # Append xterm entry to supervisord.conf
    cd /etc/supervisord/ && \
    echo '[program:xterm]' > 03-myapp.conf && \
    echo 'command=xterm' >> 03-myapp.conf && \
    echo 'autorestart=true' >> 03-myapp.conf
```


**Notes**

User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:-

```
id <username>
```