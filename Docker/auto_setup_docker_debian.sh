#!/bin/bash
print_message() {
    echo -e "\e[1m\e[44m\e[97m $1 \e[0m"
}

print_message "Setting up Docker..."

print_message "Removing previous versions of Docker"
apt-get remove docker docker-engine docker.io containerd runc

print_message "apt udate"
apt-get update

print_message "Installing needed packages"
apt-get install \
  ca-certificates \
  curl \
  gnupg

print_message "Creating keyrings"
mkdir -m 0755 -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

print_message "Getting keyrings"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

print_message "apt update"
apt-get update

print_message "Installing Docker"
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

print_message "Running Hello-World test"
docker run hello-world