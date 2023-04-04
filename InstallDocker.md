
https://thehomelab.wiki/books/promox-ve/page/setup-and-install-docker-in-a-promox-7-lxc-conainer
https://www.youtube.com/watch?v=gXuLiglJceY
https://www.youtube.com/watch?v=faoIeeZZ6ws

#pve -> USBStorage -> CT Templates download turnkey-core
#setup the container, don't start yet
#go to options -> features -> select keyctl & nesting
#start container
#login root / password
#skip first 2 steps, then install
#CTRL+C to close
apt update && apt upgrade
apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common \
  lsb-release
    
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

#verify:
systemctl status docker
apt install cifs-utils docker-compose

#check that docker is functioning properly
docker run hello-world