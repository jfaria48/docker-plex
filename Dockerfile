FROM centos
MAINTAINER Josh Wheeler <mantlepro@gmail.com>
WORKDIR /root
RUN yum install -y iproute ca-certificates openssl wget
RUN wget https://downloads.plex.tv/plex-media-server/0.9.16.6.1993-5089475/plexmediaserver-0.9.16.6.1993-5089475.x86_64.rpm
RUN yum install -y plexmediaserver*.rpm
RUN rm *.rpm
COPY PlexMediaServer /etc/sysconfig/
COPY start.sh /root
EXPOSE 32400 1900/udp 3005 5353/udp 8324 32410/udp 32412/udp 32413/udp 32414/udp 32469
CMD ./start.sh
