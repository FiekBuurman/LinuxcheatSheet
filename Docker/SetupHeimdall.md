
# make sure user exists else
```
useradd buurmans
```
```
usermod -aG sudo buurmans 
```
```
mkdir /home/heimdall
```
```
chmod -R 777 /home/heimdall
```
```
docker run -d \
  --name=heimdall \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Brussels \
  -p 7888:80 \
  -p 4443:443 \
  -v /home/heimdall/config:/config \
  --restart unless-stopped \
lscr.io/linuxserver/heimdall:latest
```









