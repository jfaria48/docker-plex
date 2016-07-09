# Containerized Plex Media Server

## First Run

    docker run --name=plex -d --hostname=rex -v plex:/root/Library/Application\ Support -v /media/plex:/media/plex:z -p 32400:32400 -p 1900:1900 -p 3005:3005 -p 32410:32410/udp -p 32412:32412/udp -p 32413:32413/udp -p 32414:32414/udp -p 32469:32469 mantlepro/plex

- `--name=desired_name` (if other than "plex", change exec line in systemd unit file to match)
- `-d` run in detatched mode
- `-v plex:/root/Library/Application\ Support` - mount metadata directory on host docker volume
- `-v /media/plex:/media/plex:z` - mount local media directory to container media directory. :z is needed for selinux
- `-p 32400:32400` - bind port 32400 to be accessible on the host

##### The following ports can also be used for different services:

    UDP: 1900 (for access to the Plex DLNA Server)
    TCP: 3005 (for controlling Plex Home Theater via Plex Companion)
    UDP: 5353 (for older Bonjour/Avahi network discovery)
    TCP: 8324 (for controlling Plex for Roku via Plex Companion)
    UDP: 32410, 32412, 32413, 32414 (for current GDM network discovery)
    TCP: 32469 (for access to the Plex DLNA Server)

### Set Up

Visit http://localhost:32400/web on the local machine to sign in and set up Plex Media Server.

The container is now set up and ready to be started and stopped with

    docker start plex
    docker stop plex

A systemd unit file has been included. Place in /etc/systemd/system to `systemctl enable|start|stop` plex.

    systemctl enable plex
    systemctl start plex

If networking is configured manually or you need to explicitly open the firewall ports, a firewalld xml has also been provided.

Add to /etc/firewalld/services/plex.xml and enable. Docker will have to be restarted to recreate its firewall

    cp plex.xml /etc/firewalld/services/plex.xml
    firewall-cmd --reload
    firewall-cmd --add-service=plex --permanent
    firewall-cmd --reload
    systemctl restart docker
