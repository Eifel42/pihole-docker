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
4. Create the folders c1 and c2 (mkdir c1, mkdir c2).
5. Make sure that the file docker-compose.yml is in the script directory.

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

The file [docker-compose.yml](scripts/docker-compose.yml) describes the setup of the Pi-Hole Stack. By using the default setup of this project, only the password of the Pi-Hole instances have to change. The default password is "secret1234". 

Noteworthy is that all commands run the folder with file docker-compose.yml. 

**Note:** *On the Raspberry Pi, the image: visibilityspots/cloudflare:alpine-3.12 works stable. This point has to figure out for new versions.*

## Build and Run Docker Containers

To run the containers, the following steps are needed:
1. **pull** load the Pi-Hole and Cloudflare docker images from the Docker Hub. 
1. **up -d** build the internal docker networks and the containers and start them.
- **-p pihole** defines the name of the stack.

The script [build-stack.sh](scripts/build-stack.sh) runs the commands.

```
docker-compose -p pihole pull
docker-compose -p pihole up -d
```

## Optional Set-Up steps

In this step, each Pi-Hole instance can set to the user's preferences. It makes it possible to enhance the default Pi-Hole filters with the lists from other providers and organizations. The use of more secure DNS providers per Pi-Hole Instance (container) is imaginable.

## Same Configuration

To run both systems with the same configuration, stop one docker container. Do the necessary configuration in the running container and copy the content from one container directory to the other.

Example Steps the configuration definied in [docker-compose.yml](scripts/docker-compose.yml):
```
docker stop pc4_pihole

# Do the configuration in pc3_pihole 
# open browser http://192.168.0.140

docker stop pc3_pihole
sudo cp ~/stack-pihole/c1/* ~/stack-pihole/c2/ -r

docker start pc3_pihole
docker start pc4_pihole
```
## Bind to Devices

To use both Pi-Hole Instances, they have to set as DNS-Servers. For test reasons, it makes sense to set them as default DNS-Server on some devices like PCs, smartphones, tablets. 

### Using in hole network

To avoid the configuration of any internet device is the easiest way to define both Pi-Hole Instances as DNS-Sever in the internet router. This step takes the risk that the internet connection can be lost. In the worse case, the internet router must set to the default provider settings.
