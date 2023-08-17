+++
title = "Install TFTP Server on Ubuntu 14.04"
description = "TFTPD Installation and configurations."
date = 2023-08-16T09:19:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["TFTP"]

[extra]
toc = true
math = false
math_auto_render = false
+++

##	Install the TFTP Server package

```bash
sudo apt-get install xinetd tftpd tftp -y
```

After successfully installing, `in.tftpd` file should be found in `/usr/sbin/` directory.

```bash
ls -la /usr/sbin/ | grep tftp
-rwxr-xr-x  1 root root   14284 Dec 16  2010 in.tftpd
```

## TFTPD configurations

The folder contains the TFTP files. The TFTP server will look up the requested file from a client in this directory.

```bash
sudo mkdir /tftpboot
sudo chmod 777 /tftpboot/
```

1. Changing the configuration in `/etc/xinetd.d/tftpd` directory

```bash
sudo vi /etc/xinetd.d/tftpd

# description: The tftp server serves files using the trivial file transfer \
# protocol. The tftp protocol is often used to boot diskless \
# workstations, download configuration files to network-aware printers, \
# and to start the installation process for some operating systems.

service tftp
{
	socket_type = dgram
	protocol = udp
	wait = yes
	user = root
	server = /usr/sbin/in.tftpd
	server_args = -c -v -s /tftpboot
	disable = no
	per_source = 11
	cps = 100 2
	flags = IPv4
}
```

2. On Ubuntu 14.04, `tftp` needs to be disabled from the `inetd.conf` file

```bash
# comment out this line: tftp           dgram   udp     wait    nobody  /usr/sbin/tcpd  /usr/sbin/in.tftpd /srv/tftp
sudo vi  /etc/inetd.conf
```

3. Restart `xinetd` service

```bash
sudo service xinetd restart
```

4. Verify configurations. Port **69** should be opened for incoming requests

```bash
sudo netstat -taplun | grep 69
udp        0      0 0.0.0.0:45369           0.0.0.0:*                           764/avahi-daemon: r
udp        0      0 0.0.0.0:69              0.0.0.0:*                           3764/xinetd  
```
