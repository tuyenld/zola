+++
title = "Linux configurations"
description = "Some useful command lines for your day-to-day tasks"
date = 2023-08-31T09:19:42+01:00

[taxonomies]
categories = ["Server"]
tags = ["Linux"]

[extra]
toc = true
math = false
math_auto_render = false
+++

# Basic setup

##	Changing colors for user, host, directory information in terminal

```bash
# https://askubuntu.com/a/123306/613914

nano ~/.bashrc
#force_color_prompt=yes		>> 		force_color_prompt=yes
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u\[\033[01;30m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```

## For loop

```bash
for f in *.txt; do
    mv -- "$f" "$(basename -- "$f" .txt).text"
done
```
## Ping show timeout
```bash
ping6 -D -O google.com

# [1566958425.967709] 64 bytes from 2404::8b: icmp_seq=23 ttl=49 time=84.6 ms
# [1566958427.820728] no answer yet for icmp_seq=24
# [1566958427.993347] 64 bytes from 2404::8b: icmp_seq=25 ttl=49 time=81.9 ms
```

## Danish characters input
Answered from [stackOverflow](https://askubuntu.com/a/1286045)
If you map CapsLock to the Compose key (you can do it through Settings → Keyboard → Layouts → Options, look for "Position of Compose key"), they will be accessible through Composeaa (å), Composeae (æ), and Composeo/ (ø). Note those are three keypresses in a sequence, not a combination to press at once. Use uppercase letters to get the uppercase variant.


## Show all process 

```bash
ps aux | grep sh

# Long line output, no wrap
ps auxww | grep dhcp
```

##	Install Open SSH

```bash
sudo apt-get install openssh-server

sudo systemctl status ssh
sudo systemctl enable ssh
```

## Disable auto sleep 16.04

```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

## Good calculator

```bash
Qalculate
```
## Change Timezone time/date

```bash
# List timezone
timedatectl list-timezones | grep -i New

# Change time/date setting to USA
sudo timedatectl set-timezone America/New_York
sudo localectl set-locale LC_TIME=en_US.utf8
sudo reboot

date +%F_%H-%M-%S
```


## Find, grep, search

```bash
# >> find

# Find file have changed in 10 minute
find /path/to/dir -mmin -10

find . -name \*.xls -exec cp {} newDir \;

# Smaller than 4G
find . -type f -size +3c -exec cp {} newDir \;
# c for bytes
# w for two-byte words
# k for Kilobytes
# M for Megabytes
# G for Gigabytes

# Ignore case sensitive
find -iname "keyword"

# >> ag

ag "stdint\.h" *
ag -G '\.java$' 'ftp' .
ag -G '\.h$' 'lnode' .

# >> grep

# Use grep --exclude/--include syntax to not grep through certain files
# -r, --recursive
# -n, --line-number 

grep someStrangeVariable -rn "stdint\.h"
grep "req->pobj->get<const char" -rn --include=\*Wrt.cpp
grep someStrangeVariable -rn --exclude=\*.{js,html}

# extract the text between, let's say, bbb and ddd.
sed 's/^.*bbb //; s/ddd.*$//' <<< "aaa bbb ccc ddd eee" 

```

## View CSV Data from the Command Line

```bash
cat file.csv | sed -e 's/,,/, ,/g' | column -s, -t | less -#5 -N -S
```

## Redirect output to file

[How do I save terminal output to a file?](https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file)

```
          || visible in terminal ||   visible in file   || existing
  Syntax  ||  StdOut  |  StdErr  ||  StdOut  |  StdErr  ||   file   
==========++==========+==========++==========+==========++===========
    >     ||    no    |   yes    ||   yes    |    no    || overwrite
    >>    ||    no    |   yes    ||   yes    |    no    ||  append
          ||          |          ||          |          ||
   2>     ||   yes    |    no    ||    no    |   yes    || overwrite
   2>>    ||   yes    |    no    ||    no    |   yes    ||  append
          ||          |          ||          |          ||
   &>     ||    no    |    no    ||   yes    |   yes    || overwrite
   &>>    ||    no    |    no    ||   yes    |   yes    ||  append
          ||          |          ||          |          ||
 | tee    ||   yes    |   yes    ||   yes    |    no    || overwrite
 | tee -a ||   yes    |   yes    ||   yes    |    no    ||  append
          ||          |          ||          |          ||
 n.e. (*) ||   yes    |   yes    ||    no    |   yes    || overwrite
 n.e. (*) ||   yes    |   yes    ||    no    |   yes    ||  append
          ||          |          ||          |          ||
|& tee    ||   yes    |   yes    ||   yes    |   yes    || overwrite
|& tee -a ||   yes    |   yes    ||   yes    |   yes    ||  append


E.g: 
	command > output.txt
	command &> output.txt &
```

## What do the fields in ls -al output mean
```
-rwxrw-r--    10    root   root 2048    Jan 13 07:11 afile.exe
?UUUGGGOOOS   00  UUUUUU GGGGGG ####    ^-- date stamp and file name are obvious ;-)
^ ^  ^  ^ ^    ^      ^      ^    ^
| |  |  | |    |      |      |    \--- File Size
| |  |  | |    |      |      \-------- Group Name (for example, Users, Administrators, etc)
| |  |  | |    |      \--------------- Owner Acct
| |  |  | |    \---------------------- Link count (what constitutes a "link" here varies)
| |  |  | \--------------------------- Alternative Access (blank means none defined, anything else varies)
| \--\--\----------------------------- Read, Write and Special access modes for [U]ser, [G]roup, and [O]thers (everyone else)
\------------------------------------- File type flag
```

## User, group
```bash
# Adding/Remove a user to a group:
sudo adduser user group
sudo deluser user group
groups USERNAME 	# To show groups with spec user
groups 				# show all groups

# list all users with their UID
awk -F: '/\/home/ {printf "%s:%s\n",$1,$3}' /etc/passwd

# Add user with specific user ID
sudo useradd sambausr -u 1003 		
# Add user without user ID
sudo adduser ldtuyen

sudo usermod -aG sudo ldtuyen

# Create default home directory for existing user in terminal						
sudo mkhomedir_helper username 						
```

## Vim
```bash
$ vi ~/.bashrc
export TERM=xterm-256color

$ vim ~/.vimrc

if $TERM == "xterm-256color"
  set t_Co=256
endif

if has('gui_running')
	set background=light
else
	set background=dark
endif
```
## Grub
```bash
$ grep menuentry /boot/grub/grub.cfg
$ sudo vi /etc/default/grub

# Start from 0
GRUB_DEFAULT=3 
GRUB_TIMEOUT=3 

$ sudo update-grub
```

## nginx

```bash
nginx -t -c /etc/nginx/nginx.conf
sudo tail -n 20 /var/log/nginx/error.log
systemctl status nginx.service
systemctl restart nginx.service
```

## Enable IP forwarding between interfaces

```bash

# Enable IP Forwarding on the fly
#---------------------------------------
sysctl -w net.ipv4.ip_forward=1
# OR
echo 1 > /proc/sys/net/ipv4/ip_forward


# Permanent setting using /etc/sysctl.conf
#---------------------------------------
cat /etc/sysctl.conf
[...]
net.ipv4.ip_forward = 1
```

## KVM

- Install

```bash
sudo apt-get install qemu-kvm libvirt-bin bridge-utils virt-manager -y
sudo adduser ldtuyen libvirtd
sudo virsh -c qemu:///system list
reboot
```

- Enable remote desktop via SSH

```bash
# Window > Install Xming from: http://sourceforge.net/projects/xming.
# Enable Remote/X11 forwarding

# SecureCRT: Session Option > Port Forwarding > Remote/X11 
# Checked Forwarded X11 Packet and Enfore X11 Authen

sed -i 's/X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config 
service sshd restart

virt-manager
```

- List all KVM

```bash
virsh list --all

virsh start ubuntu16.04
Domain ubuntu16.04 started
```
- Clone a machine

```bash
sudo virt-clone --original ubuntu-box1 --auto-clone
```

- Correct way to move kvm vm

```bash
# copy the VM's disks to the same dir on dest host
cd /var/lib/libvirt/images
# copy this xml to the dest host
virsh dumpxml win7 > win7.xml
# copy xml file and import configuration on the dest host
virsh define win7.xml

# If the disk location differs, you need to edit the xml's devices/disk node 
# to point to the image on the destination host

# If the VM is attached to custom defined networks, 
# you'll need to either edit them out of the xml on the destination host 
# or redefine them as well 
virsh net-dumpxml > netxml.xml 
virsh net-define netxml.xml 
virsh net-start NETNAME 
virsh net-autostart NETNAME
```

- Share network on kvm

- `br0` work as a swith
- `eno1` is only physical port
- any machine which use `br0` network will see `eno1`

```
  +---------+    +---------+
  |  VM1    |    |   VM2   |
  |         |    |         |
  |         |    |         |
  +----+----+    +---+-----+
       |             |
+----------------------------------------+
|      |             |                   |
|      |             |       Host machine|
|      |             |                   |
|   +--+-------------+----------+        |
|   |br0 (switch)               |        |
|   +---------------------------+        |
|                        |---|           |
+----------------------------------------+
                           |
                           |eno1
                           |
                           +
```

```bash
# >> On boot
/etc/network/interfaces
auto br0
iface br0 inet static
      address 172.16.10.2
      netmask 255.255.255.0
      network 172.16.10.0
      broadcast 172.16.10.255
      gateway 192.168.1.1
      bridge_ports eno1
      bridge_stp on
      bridge_maxwait 0
      up ip route add 10.0.0.0/24 via 172.16.10.5
      up ip route add 10.10.10.0/24 via 172.16.10.25
iface br0 inet6 static
        address 3001::20
        netmask 64
        gateway fe80::1
        autoconf 0

# >> Manually

# https://help.ubuntu.com/community/NetworkConnectionBridge
ifconfig enx00e04c68014a
# enx00e04c68014a Link encap:Ethernet  HWaddr 00:e0:4c:ff:ff:ff  
#           inet addr:192.168.0.17  Bcast:192.168.0.255  Mask:255.255.255.0
#           inet6 addr: fe80::e782:ffff:ffff:ffff/64 Scope:Link

ip addr flush dev enx00e04c68014a
ip addr flush dev <interface 2>
sudo brctl addbr br0
sudo brctl addif br0 enx00e04c68014a <interface 2>
sudo ip link set dev br0 up

sudo dhclient br0 -v
```

## Fast copy, copy certain file extension, file size, capacity
```bash
tar c sourceDirectory | pv | tar x -C destinationDirectory
tar cf - sourceDirectory | pv | (cd backup; tar xvf -)
```

## Java, JRE, JDK
```bash
sudo add-apt-repository ppa:openjdk-r/ppa \
&& sudo apt-get update -q \
&& sudo apt install -y openjdk-11-jdk
```
## Remove PPA (Linux repo list)

[How can PPAs be removed?](https://askubuntu.com/a/173209)

Alternately, as ppas are stored in /etc/apt/sources.list.d you can find the one you want to remove by entering:

```bash
ls /etc/apt/sources.list.d
```
Then when you have noted the name of that offending ppa (e.g. myppa.list), you can enter:

```bash
sudo rm -i /etc/apt/sources.list.d/myppa.list

# For example:
sudo rm -i /etc/apt/sources.list.d/inkscape_dev-ubuntu-stable-hirsute.list
```

## inkscape
- [Path operations](http://tavmjong.free.fr/INKSCAPE/MANUAL/html/Paths-Combining.html)


## screen GNU

```bash
# >> sending text input to a detached screen
# https://unix.stackexchange.com/a/13961/265821

# /scripts/sync_code.sh
screen -S sync_code -p 0 -X stuff "scripts/sync_code.sh & ^M"

```

## Rename

```bash
# Rename all *.txt to *.text
for f in *.php; do 
    mv -- "$f" "${f%.txt}.html"

done

# Rename old string to new string
for f in *; do mv "$f" "${f//old_string/new_string}"; done

```

## curl
```bash
# https://www.keycdn.com/support/popular-curl-examples
curl --request DELETE https://yourwebsite.com/
curl --request DEBUG http://192.168.0.1
curl --request POST https://yourwebsite.com/

# 5) Generating Additional Information
curl -H "X-Header: Value" https://www.keycdn.com/ -v 
```

## tcpdump
```bash
tcpdump -i wanbridge -vvvv -s 0 '(port 547 or port 546)' -e
tcpdump -i em0 -vvvv -s 0 '(port 547 or port 546)' -e

# • unreachable: 1
# • too-big: 2
# • time-exceeded: 3
# • echo-request: 128
# • echo-reply: 129
# • router-solicitation: 133
# • router-advertisement: 134
# • neighbor-solicitation: 135
# • neighbor-advertisement: 136
tcpdump -i wanbridge -vvvv -s 0 "icmp6 && ip6[40] == 134" -e

tcpdump -i gif0 -vvvv -s 0 "icmp6 && ip6 host 2001::fe" -e

# filter vlan 100
sudo tcpdump -i br0 -n -e '(vlan 100)'

## Show full packet
tcpdump -i wanbridge -en icmp -vv

```

## coredump

```bash

$ cat /proc/sys/kernel/core_pattern
core
# >> The core dump is written in the current directory of the process 
# >> at the time of the crash.

# to enable core dumps
ulimit -c unlimited 

# where $pid is the process ID of the process. 
# That link will point to the current working directory of that process.
ls -l /proc/186/cwd 


```

## python
```bash
# find python package command installed by pip
$ python3  -m site --user-base
/home/ldtuyen/.local

/home/ldtuyen/.local/bin/cld --help
```
## regx
```py
# Find string between two string
# https://regexr.com/397dr
# href="/uploads/file/PDF Week 1 Day 1a.pdf" align
patent = 'uploads(.*?)\"'
```

## Resize image keep ratio

```bash
# https://askubuntu.com/a/135489
# 1654x is width pixel

# need to install
sudo apt install imagemagick

convert '*.png[1654x]' resized%03d.png

# you can maintain the filename by using -set option. Ex:
convert "images/*.jpg[250x]" -set filename:base "%[basename]" "new_%[filename:base].jpg"
```

## Crop, cut image to one center part
```bash
# https://stackoverflow.com/a/41403898
convert input.png -gravity center -crop WxH+0+0 +repage output.png
```

## image to pdf
```bash
# Need to install
sudo apt install imagemagick

# Reduce quality if the output file is too big
convert "*.{png,jpeg}" -quality 100 outfile.pdf

# Keep same image size
# https://unix.stackexchange.com/a/74976
convert "resized*.{png}" -quality 100 -units PixelsPerInch -density 150x150 multipage.pdf

# convert images to pdf: How to make PDF Pages same size
# https://unix.stackexchange.com/a/20057
i=150; convert a.png b.png -compress jpeg -quality 70 \
      -density ${i}x${i} -units PixelsPerInch \
      -resize $((i*827/100))x$((i*1169/100)) \
      -repage $((i*827/100))x$((i*1169/100)) multipage.pdf


# Fix error: convert-im6.q16: attempt to perform an operation not allowed by the security policy `PDF' @ error/constitute.c/IsCoderAuthorized/408.
sudo vi /etc/ImageMagick-6/policy.xml

  <policy domain="coder" rights="read | write" pattern="PDF" />
</policymap>

```

## Remove pdf secure (password)

https://superuser.com/a/584710

Assuming it's simply a 'rights' (owner) password that restricts things like editing, printing, and copying (i.e. the password does not need to be entered to open the file) the following will remove the restrictions:

1. Grab https://github.com/qpdf/qpdf/releases
1. Unzip/Install and navigate to the bin folder that holds qpdf.exe (or similar for your platform)
1. Place the PDF you wish to work on in the same folder
1. Run: `qpdf --decrypt InputFile.pdf OutputFile.pdf` (use "s if the file name has spaces).
1. Do what you like with the OutputFile.

If your PDF file is user password protected, change step 4 to `qpdf --decrypt --password=yourpassword InputFile OutputFile`

## Shrinkpdf: shrink PDF files with Ghostscript (reduce pdf size)

[How can I reduce the file size of a scanned PDF file?](https://askubuntu.com/a/113547)

Method 1:

```bash
http://www.alfredklomp.com/programming/shrinkpdf/

# 150 dpi
./shrinkpdf.sh file.pdf out.pdf 150
# 120 dpi
./shrinkpdf.sh file.pdf out.pdf 120

```

Method 2:

```bash
    I use LibreOffice Draw to open the pdf.
    I then "export as pdf"
    And set "jpeg compression quality" to 10% and "image resolution" to 150 dpi

    my-document.pdf from 36 MB to 2.6 MB
```

## How to resize page to fit drawing contents in Open office/Libre Office Draw


1. Press `Ctrl-A` to select everything.
2. Under `Format>Position and Size` you can see the exact size of the selection. It's helpful to copy the value of Width and Height to an editor (or a piece of paper). Click Cancel.
3. Open `Format>Page`: Set Width and Height according to the size of the selection. Set all Margins to zero. Click OK.
4. Open `Format>Position and Size` again: Set both Position X an Position Y to zero. 
5. Click OK.


## Edit pdf on Linux

```bash

Libre Office 7.1 (Draw) > Open > PDF File
You also need to show panel: View > Page Pane

cd DEBS/
sudo dpkg -i *.deb
```

## extract-img-from-pdf

```python
# https://stackoverflow.com/a/47877930

# need to install library

# pip3 install --upgrade pip
# pip3 install PyMuPDF

# python3 extract-img-from-pdf.py
import fitz
doc = fitz.open("file.pdf")
for i in range(len(doc)):
    for img in doc.getPageImageList(i):
        xref = img[0]
        pix = fitz.Pixmap(doc, xref)
        if pix.n < 5:       # this is GRAY or RGB
            pix.writePNG("p%s-%s.png" % (i, xref))
        else:               # CMYK: convert to RGB first
            pix1 = fitz.Pixmap(fitz.csRGB, pix)
            pix1.writePNG("p%s-%s.png" % (i, xref))
            pix1 = None
        pix = None
```
## Merge / convert multiple PDF files into one PDF

```bash
# https://stackoverflow.com/a/19358402
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=merged.pdf mine1.pdf mine2.pdf

# size(output) = size(file1) + size(file2)
pdftk file1.pdf file2.pdf cat output output.pdf
```
## Remove pdf title, file metadate

```bash
sudo apt-get install libimage-exiftool-perl
# https://askubuntu.com/a/391142

exiftool -all= inputfile

```

## Split one pdf page into two pages

E.g. ![](images/split-onepage-pdf.png)

```bash
# https://askubuntu.com/a/698307

sudo apt-get install mupdf-tools
mutool poster -x 2 input.pdf output.pdf
```

## Make a sound once process is complete

```bash
make; spd-say done
```

## NPM

```bash
# https://github.com/nodesource/distributions
# install Node.js v10.x:
# Using Ubuntu
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
# Using Debian, as root
curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt-get install -y nodejs

#clean slate install.
rm -rf node_modules
npm cache clean 
npm install node-sass
```

## Find USB version is using on some port

```markdown
# Method 1
sudo apt-get install  lshw
sudo lshw

    USB 2.0 will use the ehci_hcd module
    USB 1.x will use either ohci_hcd or uhci_hcd modules.


*-usb:0
description: Video
product: Show-me-webcam Pi Webcam
vendor: Show-me-webcam Project
physical id: 3
bus info: usb@1:1.3
version: 1.00
serial: 100000000d2386db
**capabilities: usb-2.00**
configuration: **driver=cdc_acm** maxpower=500mA speed=480Mbit/s
*-usb:1
description: Generic USB device
product: USB-Serial Controller
vendor: Prolific Technology Inc.
physical id: 4
bus info: usb@1:1.4
version: 3.00
**capabilities: usb-1.10**
configuration: driver=pl2303 maxpower=100mA speed=12Mbit/s

## Method 2
$ sudo dmesg | grep usb
[ 2478.011868] usb 1-1.3: device descriptor read/64, error -71
[ 2484.103738] usb 1-1.3: device descriptor read/64, error -71
[ 2484.291754] usb 1-1.3: new high-speed USB device number 6 using ehci-pci
[ 2484.409365] usb 1-1.3: New USB device found, idVendor=1d6b, idProduct=0104, bcdDevice= 1.00
[ 2484.409370] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 2484.409373] usb 1-1.3: Product: Show-me-webcam Pi Webcam
[ 2484.409375] usb 1-1.3: Manufacturer: Show-me-webcam Project
[ 2484.409378] usb 1-1.3: SerialNumber: 100000000d2386db

cat /sys/bus/usb/devices/1-1.3/version
    2.00
```

## How to download all dependencies and packages to directory
```bash

# Khong phu thuoc vao viec package da duoc cai tren he thong hay chua
# aptitude  va synaptic thi phu thuoc vao package he thong nen se cho et qua khong dung

sudo apt install apt-rdepends
sudo apt-get download $(sudo apt-rdepends <package>|grep -v "^ ")

```

### Find package Ubuntu and Othes Linux Distribute
[pkgs.org/](https://pkgs.org/)

### Script to ignore unknow package
```
# Source: https://superuser.com/questions/1112525/ignore-apt-get-download-errors/1137335#1137335
#
# Run: ./getdepends.sh [package name]
 #!/bin/bash
 export MAXPARAMETERS=255

 function array_contains_find_index() {
     local n=$#
     local i=0
     local value=${!n}

     for (( i=1; i < n; i++ )) {
         if [ "${!i}" == "${value}" ]; then
             echo "REMOVING $i: ${!i} = ${value}"
             return $i
         fi
     }
     return $MAXPARAMETERS
 }

 LIST=( $( apt-rdepends $1 | grep -v "^ " ) )
 echo ${LIST[*]}
 read -n1 -r -p "... Packages that will be downloaded (Continue or CTRL+C) ..."

 RESULTS=( $( apt-get download ${LIST[*]} |& cut -d' ' -f 8 ) )
 LISTLEN=${#LIST[@]}

 while [ ${#RESULTS[@]} -gt 0 ]; do
     for (( i=0; i < $LISTLEN; i++ )); do
         array_contains_find_index ${RESULTS[@]} ${LIST[$i]}
         ret=$?

         if (( $ret != $MAXPARAMETERS )); then
             unset LIST[$i]
         fi
     done

     FULLRESULTS=$( apt-get download ${LIST[*]} 2>&1  )
     RESULTS=( $( echo $FULLRESULTS |& cut -d' ' -f 11 | sed -r "s/'(.*?):(.*$)/\1/g" ) )
 done

 apt-get download ${LIST[*]}
 ```