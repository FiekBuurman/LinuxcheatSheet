```
```
```
```
```
```
# https://wiki.alpinelinux.org/wiki/Docker#Docker_rootless
```
apk add docker

```
```
addgroup username docker
```
```
rc-update add docker default
```
```
service docker start
```
```
rc-update add cgroups
```
```
apk add docker-compose
```
```
