docker network create -d macvlan \
  --subnet=192.168.0.0/24 \
  --ip-range=192.168.0.137/29 \
  --gateway=192.168.0.254 \
  -o parent=your-network-device pihole_net
