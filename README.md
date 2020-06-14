# @fjedi/theta-guardian-node-docker
*Simple Docker container to run THETA Guardian node as simple as `docker run -d --name theta -e NODE_PASSWORD=some-very-secret-password --restart unless-stopped --network bridge fjedi/theta-guardian-node` :)*

![build](https://img.shields.io/docker/cloud/build/fjedi/theta-guardian-node.svg)
![build](https://img.shields.io/docker/pulls/fjedi/theta-guardian-node.svg)


### Usage

Quick start to generate and auto-renew certs for your awesome app:  
**DON'T FORGET TO CHANGE** `some-very-secret-password` to your own secure password-string!

```Bash
# Then run this command (you will need to have docker installed on your server/pc)
docker run -d \
  --name theta \
  -e NODE_PASSWORD=some-very-secret-password
  --restart unless-stopped \
  --network bridge \
  fjedi/theta-guardian-node
```

Or if you use [docker-compose](https://docs.docker.com/compose/), then your config may look smth like this:

```yaml
# docker-compose.yml
version: '2'
services:
  nginx:
    image: fjedi/theta-guardian-node
    environment:
      - NODE_PASSWORD
    volumes:
      - theta_guardian_node:/srv/theta_mainnet/guardian_mainnet
    expose:
      - 30001
    ports:
      - 30001:30001
    restart: unless-stopped
  
volumes:
  theta_guardian_node:
```

start using
```Bash
docker-compose up -d
```

## LICENCE

MIT
