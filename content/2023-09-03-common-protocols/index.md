+++
title = "ARP, SNMP, UPnP, NTP"
description = "Address Resolution Protocol, Simple Network Management Protocol"
date = 2023-09-03T10:32:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["ip", "routing"]

[extra]
toc = true
math = false
math_auto_render = false
+++

## ARP

1. TTL: in ARP is the rental period (after this time, the entry will be deleted)
2. If the switch does not know which port to send the message to, it will forward to all ports

## SNMP
```bash
wget -c https://sourceforge.net/projects/net-snmp/files/net-snmp/5.7.3/net-snmp-5.7.3.zip/download
mv download net-snmp-5.7.3.zip
unzip net-snmp-5.7.3.zip 
cd net-snmp-5.7.3/
./configure
sudo apt-get install libperl-dev
make
sudo  make install
cd perl/
perl Makefile.PL
make
mib2c --help
mib2c -c mib2c.scalar.conf bfcMgmt
mkdir ~/test
cd ~/test/
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib
mib2c -c mib2c.scalar.conf myScalar
```

```bash
sudo apt-get install libperl-dev -y

wget -c https://nchc.dl.sourceforge.net/project/net-snmp/net-snmp/5.8/net-snmp-5.8.tar.gz
tar -xzvf net-snmp-5.8.tar.gz 
cd net-snmp-5.8/
./configure
make
sudo  make install

# May be not need
sudo ln -s /usr/local/lib/libnetsnmp.so.35 /usr/lib/libnetsnmp.so.35

snmpget -v

cd perl/
perl Makefile.PL
make    | sudo make
mib2c --help
```
```bash
snmptranslate  -M "/test/snmp/all" -m ALL -Ir 1.3.6.1.4.1.2.0 
snmptranslate   -m ALL -Ir 1.3.6.1.4.1.1.2.0 

export MIBDIRS=/test/snmp/all
export MIBS=ALL

mib2c -c mib2c.scalar.conf telnetUserName

snmptranslate .1.3.6.1.4.1.4002.1.7.5.6.0
snmptranslate -Ir 1.3.6.1.4.1.2.2.2.1.1.1.2.0  
```

## UPNP

There are two types of UPnP:

1. Upnp on a Router
    - When enabled: allow devices to open ports themselves without configuring the router
    - dynamically add port formally
    - functions like `port forwarding` but no need to go to web router to configure
2. Upnp is often referred to as `UPnP IGD` for listening to music, watching movies


## NTP (Network Time Protocol)

There are two commonly used time standards:
1. GMT: Greenwitch Mean Time: take the movement of the sun as a standard, according to which 1 day has 86,400s
2. UTC: based on SI system using quantum clock, according to which 1 day has 86,400,002s
--> Nowadays, UTC is used, and GMT is used to refer to timezone

Some countries have daylight saving time **DST** (Daily Saving Time)
+ On summer days, the clock will be turned _backward_ 1-2 hours earlier, at a fixed time and for a fixed period of the year (until the end of summer for example)
+ The purpose of this is to save sunlight, get up early to go to work.
+ For example: At exactly 2 am on the 2nd Sunday of July, the clock in the US will be **turned back** to 3am and people need to get up 1 hour earlier if they don't want to be late for work. At 2 a.m. on the 3rd Sunday of April, the clock will be turned counterclockwise to 1 o'clock. Everything is back to normal.