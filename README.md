# SWNM - Sliding Window Pipeline
This repository started to keep track of the NM Sliding Window Pipeline for training the main BERT model.

Note that currently you can't close the ssh connection before the script finishes.

## Connect to DGX
1. Connect using SSH:
```sh
ssh [user]@[public-ip] -p [ssh-port]
```

## Usage
1. Build the image:
```sh
sudo docker build -t nextgpt . --force-rm --no-cache
```

2. Run the container in interactive/detached mode:
```sh
sudo docker run -it -d --name="gabrieldamata" --cpus="8.0" --memory="64g" nextgpt
```

3. Enter exec mode using the container ID
```sh
docker ps --filter ancestor=nextgpt

docker exec -it [container-id] /bin/bash
```
