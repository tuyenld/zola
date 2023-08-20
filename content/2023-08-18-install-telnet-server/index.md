+++
title = "Install Telnet Server on Ubuntu"
description = "Using telnetd package"
date = 2023-08-18T09:19:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["systemlog"]

[extra]
toc = true
math = false
math_auto_render = false
+++

## 1. Install telnet server (telnetd)

```bash
$ sudo apt-get install xinetd telnetd
```

## 2. Edit configurations

```bash
sudo vi /etc/xinetd.d/telnetd

# paste the bellow configurations
service telnet
{
        disable         = no
        socket_type     = stream
        server          = /usr/sbin/in.telnetd
        protocol        = tcp
        wait            = no
        user            = root
        flags           = IPv6
}
```

## 3. Restart xinetd service and verify that port 23 is open

```bash
sudo service xinetd restart

# you should see that port 23 is open
sudo netstat -taplun | grep 23
tcp        0      0 0.0.0.0:23              0.0.0.0:*               LISTEN      19755/xinetd

# Get server log
cat /var/log/syslog | grep xinetd
```