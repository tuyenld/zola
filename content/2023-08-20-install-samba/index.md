+++
title = "Install Samba on Ubuntu"
description = "Samba is an ultility that enables file sharing between Windows and Linux"
date = 2023-08-20T09:19:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["samba"]

[extra]
toc = true
math = false
math_auto_render = false
+++

## 1. Install samba package

```bash
sudo apt-get update
sudo apt-get install samba
```

## 2. Configure samba

1. Change samba user password

You need to change the user name according to your current Linux system.

```bash
# ldtuyen is existing user in Linux
sudo  smbpasswd -a ldtuyen				
```

2. Change samba configuration

```bash
# edit the bellow configuration according to your system
sudo vi /etc/samba/smb.conf

[ldtuyen]
path = /home/ldtuyen
available = yes
valid users = ldtuyen
read only = no
browsable = yes
public = yes
writable = yes
```

3. Restart samba service

```bash
sudo /etc/init.d/smbd restart
```

## 3. Configure Windows machine

On your Windows machine, right click to the My Computer icon >> 
Map network Drive >> Folder: \\YOUR_SAMBA_IP_ADDRESS\ldtuyen

**YOUR_SAMBA_IP_ADDRESS** need to be replaced by the actual IP address of your Linux machine.