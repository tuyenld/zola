+++
title = "Install Systemlog Server on Ubuntu"
description = "Using syslog-ng package"
date = 2023-08-17T09:19:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["systemlog"]

[extra]
toc = true
math = false
math_auto_render = false
+++

## 1. Install syslog-ng package

```bash
sudo apt-get install syslog-ng
```

## 2. Create a configuration file

Make sure that the username is existed in your system.

```bash
sudo vi /etc/syslog-ng/conf.d/ldtuyen.conf

# Modify the bellow text to reflect the user in your system

# https://blog.webernetz.net/basic-syslog-ng-installation/
# --------------------------------------------------
options {
        create_dirs(yes);
        owner(ldtuyen);
        group(ldtuyen);
        perm(0644);
        dir_owner(ldtuyen);
        dir_group(ldtuyen);
        dir_perm(0755);
};
# --------------------------------------------------
source s_udp {
        network (
                ip-protocol(6)
                transport("udp")
                port(514)
        );
        network (
                transport("udp")
                port(514)
        );
};
# --------------------------------------------------
destination d_host-specific {
        file("/var/log/ldtuyen_log/$HOST/$YEAR/$MONTH/$HOST-$YEAR-$MONTH-$DAY.log");
};
log {
        source(s_udp);
        destination(d_host-specific);
};
```

## 3. Restart the syslog-ng service

```bash
sudo service syslog-ng restart
sudo netstat -taplun | grep sys
sudo service syslog-ng status
sudo service syslog-ng restart
```

## 4. Test the syslog server

You need to connect the syslog client to this server. In this case **172.16.10.10** is the IP address of the client.

```bash
tail -F ldtuyen_log/172.16.10.10/2020/01/172.16.10.10-2020-01-09.log
```