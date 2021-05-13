# Set-Up Pi-Hole Stack

The stack needs an installation of docker and docker-compose on the Linux system.  

## Directory Structure

The installation has the following structure on the home directory of a Raspberry Pi (/home/pi). 

└── home
    └── pi
        └── stack-pihole

1. Create the folder structure with /home/pi/stack-pihole (cd ~, mkdir stack-pihole).
2. copy all files from the script folder to stack-pihole.

##

##

```
docker-compose -p pihole pull
docker-compose -p pihole down
docker-compose -p pihole up -d
```
