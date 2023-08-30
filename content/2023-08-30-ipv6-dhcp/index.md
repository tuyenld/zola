+++
title = "IPv6 and DHCP"
description = "Internet Protocol version 6 and Dynamic Host Configuration Protocol (DHCP)"
date = 2023-08-30T09:19:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["dhcp, ipv6"]

[extra]
toc = true
math = false
math_auto_render = false
+++

## IPv6
### Redirect IPv6

```cpp
/*
  +-------------+         +------------+
  |             |   3     |            |
  |             |---------|            |
  |   R1        |         |    R2      |
  |             |         |            |
  +-------------+         +------------+
          ---                /
            2\----         -/ 4
                  \--     /
              +-------------+
              |             |
              |             |
              |   Switch    |
              |             |
              |             |
            --+-------------+-
          -/                  \-                          -
        -/  1               5   \-
      -/               +------------+
+------------+         |            |
|            |         |            |
|            |         |            |
|   PC1      |         |   PC2      |
|            |         |            |
+------------+         +------------+
 */
```
- Normal scenario: 1->2->3->4->5
- Redirect IPv4: 1->4->5
- Redirect IPv6: 1->5

**Tunnel vs NAT64**
![tunnel-vs-NAT64](images/tunnel-vs-NAT64.svg)

### DHCPv6

- DHCPv6 runs basically in 4 steps (SARR)
   - Solict -> Advertise -> Request -> Reply
- Router Advertise contains information about Prefix Length and Prefix address
- Configure ISC DHCPv6 server on Centos
   - The `prefix-length` in the PD message sent by the server depends on the `prefix-len` that the client sends in the DHCPv6 Solicit message
   - If the client request prefix is different from the one configured on the server, the PD will return `Not available`
- Configure DHCPv6 server running on Cisco IOS
   - Ignore `prefix-length` sent by the client --> returns the PD configured on the server.
- Notice the difference between the two messages: Router Adv (RA) and DHCPv6 Adv (although both are Advertise).
- Rapid commit:
   - Advertise -> Reply now
   - The DHCPv6 server's Reply message must have a `rapid-commit` field (the DHCPv6 Jagonet server does not have this field)


## DHCP

- DHCP works basically in 4 steps: Discover-Offer-Request-ACK (abbreviated as DORA for easy remembering)
   - DHCP Discover gives the options that the client wants to get.
   - DHCP Offer is based on the options requested by the client and the options it is configured to respond to to the client.

DHCP uses ARP to determine if that IP address is already in use by a host.
- In the BSD Redhat library, all system calls call the `sosend` function
- DHCP Server differentiates to grant IP to CPE, CM, eMTA based on
   - option 60 `vendor-class-identifier` in DHCP Discover message
   - docsis -> CM; pktc -> MTA; eRouter -> CPE

**For DOCSIS DHCP server:** 
- DHCP Offer and DHCP ACK need to have some specific fields (see more [CM-SP-MULPIv3.1](https://volpefirm.com/wp-content/uploads/2017/01/CM-SP-MULPIv3.1-I10-170111.pdf))
  - `yiaddr`: your IP address
  - IP of TFTP server
  - Config file name on TFTP server
- CMTS relies on X/Y downstream/upstream channel to determine which DHCP request is coming from CM or CPE then change the Gateway IP address `GIADDR`

**Notes:**
   - `file name` located in the header is **boot file name**
   - option `file name`: located in the option _option 67_ - suboption.

### DHCP Relay agent

```cpp
/*
                     ┌──────────────┐
                     │  DHCP Server │
     ┌─────────┐     │              │
     │ Router  ├─────┴──────────────┘
     │    R1   │
     └─┬────┬──┘
       │    │
┌──────┤    ├───────┐
│      │    │  PC2  │
│  PC1 │    │       │
└──────┘    └───────┘
 */
```

- In this mode Router R1 does not directly assign IPs to PC1 and PC2, but it will forward this DHCP message to the dedicated DHCP Server.
- PC1 and PC2 do not need to know the address of the DHCP Server.
- `255.255.255.255` is a broadcast message from the client, if the Router is not configured as a Relay Agent, it will discard this message.
   - Discover-Request messages have the same `transaction ID`
   - The Request-ACK message has the same `transaction ID`
- Time Release is the Rebinding time when Renew fails.
   - Default: Renew 30s; Rebinding 60s