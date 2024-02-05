FROM debian:bookworm-20240130-slim
MAINTAINER Anders Nyvang

ENV TZ=Europe/Copenhagen

WORKDIR /multitool

RUN DEBIAN_FRONTEND=noninteractive && \
    set -x && \
    apt-get update -qq && \
    apt-get upgrade -qq && \
    apt-get install -qq --no-install-recommends \
      apt-transport-https ca-certificates gdebi-core tzdata man-db bash-doc bash-completion \
      screen htop zip unzip p7zip tree less groff-base python3-docopt \
      geoip-bin wget curl lynx inetutils-tools inetutils-traceroute \
      net-tools tcptraceroute ethtool git iperf3 iproute2 jq lftp mtr-tiny netcat-openbsd \
      procps rsync socat tcpdump ncat openssh-client speedtest-cli \
      python3 python3-venv python3-pip python3-postgresql \
      postgresql-client && \
    rm -rf /var/lib/apt/lists/*

COPY /root/* /root/

COPY /root/.bashrc /etc/skel/

COPY /bin/* /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]