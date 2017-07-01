# Containerized Plex Media Server

## First Run

    docker run -d -it --name=plex --hostname=rex -v plex:/opt -v /media/plex:/media/plex:z -p 32400:32400 -p 1900:1900 -p 3005:3005 -p 32410:32410/udp -p 32412:32412/udp -p 32413:32413/udp -p 32414:32414/udp -p 32469:32469 mantlepro/plex

- `-d` run in detached mode
- `-it` interactive, pseudo tty
- `--name=desired_name` (if other than "plex", change exec line in systemd unit file to match)
- `--hostname=desired_name` add hostname here to show a consistent hostname in the plex user interface
- `-v plex:/opt` - mount metadata directory on host docker volume
- `-v /media/plex:/media/plex:z` - mount local media directory to container media directory. `:z` is needed if selinux is enabled
- `-p 32400:32400... etc.` - bind ports to be accessible on the host


#### Ports

    TCP: 32400 Web interface
    UDP: 1900 (for access to the Plex DLNA Server)
    TCP: 3005 (for controlling Plex Home Theater via Plex Companion)
    UDP: 5353 (for older Bonjour/Avahi network discovery)
    TCP: 8324 (for controlling Plex for Roku via Plex Companion)
    UDP: 32410, 32412, 32413, 32414 (for current GDM network discovery)
    TCP: 32469 (for access to the Plex DLNA Server)

## Set Up

Visit http://localhost:32400/web on the local machine to sign in and set up Plex Media Server.

If local machine access isn't possible, forward port 32400 to your local machine using ssh port forwarding `ssh -L 32400:localhost:32400 server_hostname` and visit http://localhost:32400/web for initial configuration.

The container is now set up and ready to be started and stopped with

    docker start plex
    docker stop plex

A systemd unit file is also available in the repository. Place in `/etc/systemd/system/plex` and `systemctl daemon-reload` to be able to control plex with systemd `systemctl enable|start|stop plex`.

    systemctl enable plex
    systemctl start plex

If you need to explicitly open the firewall ports use the firewalld definition provided in the repo.

Add to `/etc/firewalld/services/plex.xml` and enable. Docker may have to be restarted as well to be able to recreate the docker firewall definitions.

    cp plex.xml /etc/firewalld/services/plex.xml
    firewall-cmd --reload
    firewall-cmd --add-service=plex --permanent
    firewall-cmd --reload
    systemctl restart docker

## Notes

Pull requests are welcome.
