FROM ubuntu:bionic
#
MAINTAINER Alexander Radyushin <alexander@fjedi.com>

ENV RUNTIME_DEPS="curl wget mc nano iputils-ping net-tools"

# Install required packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y $RUNTIME_DEPS

RUN mkdir -p /srv/theta_mainnet/bin \
  && mkdir -p /srv/theta_mainnet/guardian_mainnet/node \
  && cd /srv/theta_mainnet \
  && curl -k --output bin/theta `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=theta'` \
  && curl -k --output bin/thetacli `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=thetacli'` \
  && curl -k --output /srv/theta_mainnet/guardian_mainnet/node/config.yaml `curl -k 'https://mainnet-data.thetatoken.org/config?is_guardian=true'` \
  && wget -O guardian_mainnet/node/snapshot `curl -k https://mainnet-data.thetatoken.org/snapshot` \
  && chmod +x bin/theta && chmod +x bin/thetacli
RUN ln -s /srv/theta_mainnet/bin/theta /usr/local/bin/ && ln -s /srv/theta_mainnet/bin/thetacli /usr/local/bin/

# 16888 - RPC API, 30001 - p2p
EXPOSE 16888 30001
#
VOLUME ["/srv/theta_mainnet/guardian_mainnet"]
#
CMD ["sh", "-c", "/srv/theta_mainnet/bin/theta start --config=/srv/theta_mainnet/guardian_mainnet/node --password=$NODE_PASSWORD"]
