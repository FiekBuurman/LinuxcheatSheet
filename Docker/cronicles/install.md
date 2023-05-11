
# https://github.com/jhuckaby/Cronicle/blob/master/docs/Setup.md#single-server

apt install nodejs && apt install npm
curl -s https://raw.githubusercontent.com/jhuckaby/Cronicle/master/bin/install.js | node


https://github.com/jhuckaby/Cronicle/archive/refs/tags/v0.9.21.tar.gz

mkdir -p /opt/cronicle
cd /opt/cronicle
curl -L https://github.com/jhuckaby/Cronicle/archive/v0.9.21.tar.gz | tar zxvf - --strip-components 1
npm install
node bin/build.js dist



/opt/cronicle/bin/control.sh setup

"mail_options": {
	"secure": true,
	"auth": { "user": "fiekbuurman@gmail.com", "pass": "smywpknvvjqmajpm" },
	"connectionTimeout": 10000,
	"greetingTimeout": 10000,
	"socketTimeout": 10000
}

docker run \
        -v /var/run/docker.sock:/var/run/docker.sock:rw \
        -v $PWD/data:/opt/cronicle/data:rw \
        -v $PWD/logs:/opt/cronicle/logs:rw \
        -v $PWD/plugins:/opt/cronicle/plugins:rw \
        -v $PWD/app:/app:rw \
        --hostname localhost \
        -p 3012:3012\
		-UID
        --name cronicle \
        bluet/cronicle-docker:latest