#!/bin/bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${USER}
sudo systemctl enable --now containerd
sudo systemctl enable --now docker
sudo docker network create --driver=bridge --subnet=10.0.0.0/16 --ip-range=10.0.0.0/24 --gateway=10.0.0.1 proxy
sudo apt update
touch ./aio/acme.json
chmod 600 ./aio/acme.json
sudo apt install apache2-utils -y
sudo mkdir /docker
sudo chown -R ${USER}:${USER} /docker
mkdir -p /docker/data/media/complete
mkdir -p /docker/data/media/incomplete
mkdir -p /docker/data/postgres
mkdir -p /docker/config/jellyfin
mkdir -p /docker/logs/traefik
touch /docker/logs/traefik/access.log
touch /docker/logs/traefik/traefik.log
read -p 'Username: ' uservar
read -sp 'Password: ' passvar
echo
htpasswd -nb $uservar $passvar