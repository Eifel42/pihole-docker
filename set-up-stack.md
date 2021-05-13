# Set-Up Pi-Hole Stack

The stack needs an installation of docker and docker-compose on the Linux system. The Stack builds four containers: two Pi-Hole instances and two Cloudfare DNS clients. The Cloudflare containers will be protected (hide) by a private docker subnet.

## Directory Structure

The installation has the following structure on the home directory of a Raspberry Pi (/home/pi). 
```
/
└── home
    └── pi
        └── stack-pihole
            └── c1
            └── c2
```
1. Create the folder structure with /home/pi/stack-pihole (cd ~, mkdir stack-pihole).
2. Move to folder stack-pihole (cd ~/stack-pihole).
3. Copy all files from the script folder to stack-pihole.
4. Create the folders c1 and c2 (mkdir c1, mkdir c2).


The directories c1 and c2 contain the local setup of each Pi-Hole Instance. It is necessary for upgrading the Pi-Hole to new versions. The containers store the configuration in the folders.

## Build the Network

The following docker command builds a network and sets a private range for docker containers to the network. Set the -o parent parameter to the primary network device of the system. The command is found [here](scripts/create-privlan.sh).

```
docker network create -d macvlan \
  --subnet=192.168.0.0/24 \
  --ip-range=192.168.0.137/29 \
  --gateway=192.168.0.254 \
  -o parent=your-network-device pihole_net
```

## docker-compose.yml

The file [docker-compose.yml](scripts/docker-compose.yml) describes the setup of the Pi-Hole Stack. By using the default setup of this project, only the password of the Pi-Hole instances can change. The default password is "secret1234". 

Noteworthy is that all commands run the folder with file docker-compose.yml. 

## Build and Run Docker Containers

To run the containers, the following steps are needed:
1. **pull** load the Pi-Hole and Cloudflare images from the Docker Hub. 
1. **up -d** build the internal docker networks and the containers and start them.
- **-p pihole** defines the name of the stack.

The script [build-stack.sh](scripts/build-stack.sh) runs the commands.

```
docker-compose -p pihole pull
docker-compose -p pihole up -d
```
