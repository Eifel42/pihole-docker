# Set-Up Pi-Hole Stack

The stack needs an installation of docker and docker-compose on the Linux system. The Stack builds four containers: two Pi-Hole instances and two Cloudfare DNS clients. The Cloudflare containers will be protected (hide) by a private docker subnet.

## Directory Structure

The installation has the following structure on the home directory of a Raspberry Pi (/home/pi). 
```
└── home
    └── pi
        └── stack-pihole
```
1. Create the folder structure with /home/pi/stack-pihole (cd ~, mkdir stack-pihole).
2. Copy all files from the script folder to stack-pihole.
3. Move to folder stack-pihole (cd ~/stack-pihole).

## Build the Network



##

```
docker-compose -p pihole pull
docker-compose -p pihole down
docker-compose -p pihole up -d
```
