+++
title = "Firewall on Ubuntu/Linux"
description = "Using ufw, ebtables, iptables and Netfilter"
date = 2023-08-22T09:19:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["firewall"]

[extra]
toc = true
math = false
math_auto_render = false
+++

## Firewall ufw

```bash
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-16-04
sudo ufw status verbose

# enable ufw firewall
sudo ufw enable

# allow a service
sudo ufw allow ssh
sudo ufw allow samba
```

## ebtables, iptables and Netfilter
```bash
# https://backreference.org/2010/06/11/iptables-debugging/

iptables -t raw -S -v  | grep helper
iptables -t filter -S -v | grep helper
iptables -t nat -S -v   | grep helper

iptables -t raw  -L --line-numbers
iptables -t filter -L INPUT -v --line-numbers

# see number of package going chain
iptables -t nat -nvL

## debug out going package
ip6tables -t raw -A PREROUTING -p ipv6-icmp -d 2001:db8:1111:1111::3 -j TRACE
## debug in comming package
ip6tables -t raw -A PREROUTING -p ipv6-icmp -d 2001:db8:0:22:22:22:22:22 -j TRACE

# debug in/out package
iptables -t raw -A PREROUTING -p gre -j TRACE
iptables -t raw -A PREROUTING  -p udp -m multiport --dports 67,68 -j TRACE

# Get status of packet
iptables -m contrack --ctstate RELATED,ESTABLISHED
```

`ebtables, iptables` are modules in **Netfilter** project. Netfilter will be loaded as driver module.
ebtables and iptables are commands (apps) used on userspace.
- ebtables is mainly used at layer 2 MAC but can also use some functions at layer 3 network
- iptables is mainly used at Layer 3 Network but can also provide some functionality at Layer 2 MAC

### Policy and chain


- In a chain
   - Rules are added to each list
   - Packet is checked with each rule
     - If the condition is satisfied, then execute target [ACCEPT, DROP]
     - If the condition is not satisfied:
       - Make the next rule check
       - If no rule is satisfied, perform POLICY (a chain when initializing must have POLICY: ACCEPT or DROP)

**Rules for using POLICY**

| 1                                               | 2                                   |
| ----------------------------------------------- | ----------------------------------- |
| Default policy is DROP; add rule is ACCEPT      | Default is ACCEPT; add rule is DROP |
| Use for Input Chain                             | Use for output chain                |
| Only allow access from trusted IP or port range | Block only 1 unauthorized IP        |

The table includes many chains, the chain contains many rules. Target is already defined:

| Target | Function                                                   |
| ------ | ---------------------------------------------------------- |
| ACCEPT | Allow packet to passthrough the firewall                   |
| DROP   | Deny access by the packet                                  |
| REJECT | Deny access and notify the sender                          |
| QUEUE  | Send packet to userspace                                   |
| RETURN | Jump to the end of chain and let default target process it |

**Specific examples**
`iptables -m phydev -i -o`
In order for `iptables` to distinguish packets coming from eth0, eth1..., it must load the `physdev` module.
But this module can only be used for Bridge packet, not for Routing packet.
For example, the incoming HTTPS message is a routing packet, so this method cannot be used.