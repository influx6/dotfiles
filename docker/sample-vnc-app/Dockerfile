FROM influx6/novnc:latest
MAINTAINER "Alexander Ewetumo <alex.ewetumo@gmail.com>"

ADD 03-app.conf /etc/supervisord/
ADD app.sh $HOME/app.sh

# RUN apk --add --update curl libxtst libxrender

# run script to set uid, gid and permissions
CMD ["/entrypoint.sh"]
