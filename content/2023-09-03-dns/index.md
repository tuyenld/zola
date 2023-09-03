+++
title = "DNS"
description = "Domain Name System"
date = 2023-09-03T09:19:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["dns"]

[extra]
toc = true
math = false
math_auto_render = false
+++

## DNS 

1. Load Distribution: Has web cache, saves frequently accessed information
2. Domain: foo.com, Hostname: relays.foo.com
3. FQDN: Fully qualified domain name
4. Types of DNS: A, MX, NS, Alias
5. DNS Zone: record includes its name and IP address

### Change DNS server Ubuntu 14.04

```bash
# >> Persistent
$ sudo nano /etc/network/interfaces
#Below iface eth0 inet static add the following line:
dns-nameservers 10.10.10.12 8.8.8.8	#This will use Google's DNS servers.

# Note: as chaos says, you can also edit /etc/resolv.conf 
# but these changes will be overwritten on reobot.
# >> Temprary
$ vi /etc/resolv.conf
nameserver 8.8.4.4

# Restart your network
$ sudo /etc/init.d/networking restart		
```
### Show DNS server after Reboot

```bash
nmcli device show <interfacename> | grep IP4.DNS	# Ubuntu >= 15
nmcli dev list iface <interfacename> | grep IP4		# Ubuntu <= 14
```

### Assign DNS record

```bash
$ sudo vi /etc/hosts 

127.0.1.1       mypc
10.10.10.94     example.com
$ sudo service network-manager restart
# OR 	
$ sudo service networking restart
```

### nslookup

```bash
ldtuyen@pc:~$ apt-cache search nslookup
# dnsutils - Clients provided with BIND
# knot-dnsutils - Clients provided with Knot DNS (kdig, knslookup, knsupdate)
# libbot-basicbot-pluggable-perl - extended simple IRC bot for pluggable modules
# libnet-nslookup-perl - simple DNS lookup module for perl
ldtuyen@pc:~$ 
ldtuyen@pc:~$ sudo apt-get install dnsutils
```
