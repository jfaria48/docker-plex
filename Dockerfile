FROM centos
MAINTAINER Josh Wheeler <mantlepro@gmail.com>
WORKDIR /root
RUN yum install -y iproute ca-certificates openssl wget
RUN wget -q https://downloads.plex.tv/plex-media-server/1.0.2.2413-7caf41d/plexmediaserver-1.0.2.2413-7caf41d.x86_64.rpm
RUN yum install -y plexmediaserver*.rpm
RUN rm *.rpm
COPY sysconfig /etc/sysconfig/PlexMediaServer
COPY start.sh /root
EXPOSE 32400 1900/udp 3005 5353/udp 8324 32410/udp 32412/udp 32413/udp 32414/udp 32469
CMD ./start.sh
