# https://github.com/jokob-sk/Pi.Alert/blob/main/dockerfiles/README.md

```
docker run -d --network=host \
  -v /docker/pialert/config:/home/pi/pialert/config \
  -v /docker/pialert/db:/home/pi/pialert/db \
  -e TZ=Europe/Brussels \
  -e PORT=20211 \
   --restart unless-stopped \
  jokobsk/pi.alert:latest

```