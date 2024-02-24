# Kernel Diary
This will contain daily experiences with the kernel

## Commands
Daily used COMMANDS will be placed

Adding & Removing git remote to a local repository\
`git remote -v` shows the remote repositories added\
`git remote rm origin` removes the origin remote url\
`git remote add origin <repository url>` adds new repository url

## Bash Command

`$_` will give the previous command last argument

## dmidecode - DMI(Desktop Management Interface)

This command provides us the information of all the hardware we
have. What's the memory type, processor, PCIE, etc. in human 
readable form.

`sudo dmidecode -t 17`	gives the memory information 
`sudo dmidecode -t 0` gives BIOS info

## disk usage

Following will give you the disk usage of the current directory
in human readable form

`du -h ./`

## Number of content in a Directory

This command will give how many files/dirs does the given dir have

`ls -U | wc -l`

## Format disk

This will give the partition table 

`fdisk -l` 

## LTTng Linux Tracing Toolkit Next Gen

Required Deps

`sudo apt install openjdk-19-jdk`

For installing the LTTng 

`sudo apt install lttng-tools lttng-modules-dkms liblttng-ust-dev`

LTTng can be used with Trace Compass

[Trace Compass Download](https://projects.eclipse.org/projects/tools.tracecompass/downloads)

## eBPF (extended Berkeley Packet Filter)

eBPF is used to provide the supporting infrastructure within the kernel.

To use BPF, the system requirements are

- Linux kernel 4.0 or Later
- Kernel Support for BPF
- BCC or bpftrace frontends installed.
- Root access on the target system.

## Disabling firewall on Linux use ufw(Uncomplicated FireWall)

To check the status of firewall 

`sudo ufw status`

To disable the firewall in ubuntu

`sudo ufw disable`

## FileZilla

`sudo apt install filezilla`

## Docker Commands

`docker run -itd --name pi python`
`docker images`
`docker rm <cont_id>`

## Kernel download

Following will clone the kernel with some commits made recently
which saves a lot of disk space

`git clone --depth=3 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git`

Following will give you menu in gui format
`make xconfig`

kbuild is open source framework that provides some clues to the user via its UI.

 - [.] :- In-Kernel feature, Boolean Option(ON/OFF)
 	- [*] :- Compiled & built in kernel Image (y)
	- [[]] :- OFF (n)
 - <.> :- Feature which is in tristate
 	- <*> :- Compiled & built in kernel image (y)
	- <M> :- Module, compiled & built as Linux Kernel Module(LKM) (m)
	- < > :- OFF (n)
 - {.} :- A dependency exists for this conifg option, (m) or built in to kernle image
 - -*- :- A dependency requires this to be compiled in (y).
 - (...) :- Prompt an alphanumeric input is required
 - <Menu_entry> ---> :- A sub-menu follow

 ## cscope

 Installing cscope

 `sudo apt install cscope`
 
 Creating a database

 `cscope -Rbq`
 - R : Recursive subdirs
 - b : build database
 - q : fast creation

## tar

To extract a `*.tar.xz` in a particular directory  use following

`tar xf xyz.tar.xz --directory=${HOME}/kernels/`

## Kbuild System

The linux kernel has implemented it's own building system which uses `make`
for compiling the kernel. For menu based TUI kernel uses `make menuconfig`
which give much flexiblity for the changing the options.
`make help` will show all the options for building the kernel.

`linux/Kconfig` is the main file for `menuconfig` the general setup config starts from here. This is the initial screen of `menuconfig`
Every dir has it's own `kconfig` file which is source form `Kconfig`

To include a new config in `General Setup` we have to edit `init/Kconfig`.
This will include a new option in the `menuconfig` under first option `General Setup`. Following is the edit in the `init/Kconfig`

This addition is done under `LOCALVERSION_AUTO`

```
... 
          which is done within the script "scripts/setlocalversion".)
 
config PI_KERNEL_CHECK
       bool "Test the pi kernel for the creating the new menu item in Kernel config"
       default n
       help
               This option is merely a dummy 'test'; this will show you how
               to interact with the linux kernel

               Try setting this option to 'Y' (true), save & exit & see the 
               effect this has by doing:
                       grep "CONFIG_PI_KERNEL_CHECK" .config

               if unsure, say N

```

## cpu cmd

`lscpu`

`nproc`

## Making temp dir

`mktemp -d`   This will create a new temp dir under `/tmp`

Store it in a variable & use it anywhere

`TMPDIR=$(mktemp -d)`

Best option to use is 

```bash
cd `mktemp -d`
```

## Grub edit

Following is the grub. The file is `sudo vi /etc/default/grub`

```
# This will run the latest installed kernel if kept  GRUB_DEFAULT=0
GRUB_DEFAULT="Advance options for Ubuntu>Ubuntu, with Linux 6.2.0.32-generic"
#GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=20
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX=""
```
To add a background Image to grub add following line to above

`BACKGROUND_IMAGE="Path to your.png"`

## initramfs

initial RAM file system

## Monitor dmesg live

To monitor dmesg live follow. 
-w --> follows the last line

`sudo dmesg -wH`

## Kernel debug levels

There are 8 Debug levels starting form 0 in Linux Kernel

 - KERN_EMERG	
 - KERN_ALERT
 - KERN_CRIT
 - KERN_ERR
 - KERN_WARNING
 - KERN_NOTICE
 - KERN_INFO
 - KERN_DEBUG

## Scanner Driver with PDF arranger

`sudo apt install simple-scan pdfarranger`

## GRUB os-prober

I've encountered an error when booting the linux.
The GRUB doesn't show multiple OS which are installed. It only shows a single OS.

The `sudo os-prober` will show how many OS are currently installed on your
ssd.

To remove this edit `/etc/default/grub` & add

`GRUB_DISABLE_OS_PROBER=false`

To remove the complete warning you can edit `/etc/default/grub.d/*_ubuntu.cfg`
and remove the warning.

## readelf

elf - executable and linking format

`readelf -h ./hello` --> This will give output for headers for elf

`readelf -l ./hello` --> file segment headers

## Connecting two machines using Cross over cable

Connect two machines with LAN cable 

 - Open the the Network Manager & add a new wiered network.
 - Choose the MAC Address for each machine.
 - Choose the IPv4 for the & selected the address to Manual.
 - Enter the IP Address `10.0.0.1` --> this will be linked with the machine.
 - Enter the NetMask as 255.255.255.0
 - Now try to ping to other machine using `ping 10.0.0.2`

## inxi script

`inxi` is a script which displays system information for console & IRC.

`inxi -Fxxxrz` show Full details, z hides personal info, r gives out repo data

## List Connected Monitors

`xrandr --listmonitors` This will give out the resolutions as well

## QEMU creating images & mounting

Using `debootstrap` a basic Debian system. We'll install a debian distro
in a directory. We'll create an qemu image file on a directory & use 
debootstrap in the mount point.

```bash
qemu-img create debian.img 10g #This will create an image of 10GB named debian.img
mkfs.ext4 debian.img
mkdir mount-img
sudo mount -o loop debian.img mount-img
sudo debootstrap --arch amd64 bookworm mount-img #add a distro to the dir mount-img
sudo chroot mount-img #This will take you to the root of the file system
passwd		#Set a new password for the debian system
sudo umount mount-img
rmdir mount-img
```

To run the qemu basic system

```bash
qemu-system-x86_64 -kernel arch/x86/boot/bzImage -hda debian.img \
  -append "root=/dev/sda"
```

## Generating GPG key

GNU Privacy Guard is used for sending & recieving data securly. \
Generating a key is as follows

`gpg --full-generate-key`

Select a default or the preffered kind of key in the output. \
```
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
  (14) Existing key from card
Your selection? 1
```

Next will be the keysize of the key. I'm entering 4096 which is max bits.

```
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
```

Next will be the expiry time of the key. After this time you'll have to renew the key. \
I'll be entering 3 days

```
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 3
```

After this is the personal info you'll need to fill in. This will gnerate
the new key for you.

Listing all the keys

`gpg --list-secret-keys --keyid-format long`

Output will be listing of all the keys you have

```
-----------------------------
sec   rsa4096/AxxxxxxxxxxxxxxF 2023-12-16 [SC] [expires: 2023-12-19]
      7xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
uid                 [ultimate] <Name of user> (comment) <mail@mail.com>
ssb   rsa4096/xxxxxxxxxxxxxxx4 2023-12-16 [E] [expires: 2023-12-19]
```

Copy `sec` key after `/` & apply gpg.  \
Printing the GPG key id which could be shared to public.

`gpg --armor --export AxxxxxxxxxxxxxxF`

Adding the gpg key to git 

`git config --global user.signingKey AxxxxxxxxxxxxxxF`

Sign all commits using gpg by default use following

`git config --global commit.gpgsign true`

After the key expires following will be the error

```bash
error: gpg failed to sign the data:
[GNUPG:] KEYEXPIRED 1xxxxxxxx1
[GNUPG:] KEY_CONSIDERED 7xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxF 3
gpg: skipped "6xxxxxxxxxxxxxxx": Unusable secret key
[GNUPG:] INV_SGNR 9 6xxxxxxxxxxxxxxx
[GNUPG:] FAILURE sign 54
gpg: signing failed: Unusable secret key

fatal: failed to write commit object
```

Removing the Old keys

```bash
gpg --list-secret-keys
gpg --delete-secret-keys 7xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxF 

```

## grep pattern

grep pattern from a file & display content below it

`grep -A 10 "GPG" README.md`

## xclip

copy the content to the clipboard using xclip

`xclip -sel clip f_name`

## Using Syzkaller

Install deps `qemu` `git` `openssh` `go`

```bash
qemu-system-x86_64 -m 8G -smp 8 -kernel ../test_main/arch/x86/boot/bzImage -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" -drive file=./bookworm.img,format=raw -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 -net nic,model=e1000 -enable-kvm -nographic -pidfile vm.pid 2>&1 | tee vm.log
```

## Exporting a variable without using a full path

To export a var `export KERNEL=../test` will give the o/p after echo `../test` \
To get extract full path of the dir do following \
```bash
export KERNEL=`readlink -f ../test`
```

## Creating a system daemon

Daemon process run in the background which don't have tty. These are started by \
init scripts. Daemon file are places in `/etc/systemd/system/` 
For creating a system daemon you need to create a `.service` file. suppose we \
have a file called `v4l2_param` & this is to be run at the time of boot.

Below is the `abc.service` file
```bash
# Place this file in /etc/systemd/system/
# Change the path for zOS_V4L script
# Run following commands after placing 
# systemctl daemon-reload
# systemctl enable zOS_V4L.service
[Unit]
Description=Run script at startup after network becomes reachable
After=getty.target

[Service]
Type=simple
RemainAfterExit=yes
ExecStart=/home/mzjet/work/system_supervisor/zOS_V4L
TimeoutStartSec=0

[Install]
WantedBy=default.target
```

## Creating SECURED HASH ALGORITHM checksum

To check if the file is not altered or changed or malfunction SHA is used 
creating the checksum file

`sha512sum file1 > checksum_file` \
`sha512sum file2 > checksum_file` \

If the file is not alterted the following command will just produce `OK` \
`sha512sum --check checksum_file` \
Above will check if the file is changed or not & verify integrity

## Check the Installation date for Linux distro

Just by doing `stat` on root dir you'll get the `Birth` date with time. \
`stat /`

## Changing File permission 

Change file permissions at same time like removing other permission & adding \
user & group permission \
`chmod u+rwx,g-rx,o= filename`

## Check the binutils version

To check buintils version use `ld -v`

## Multiple ssh keys for github

If the error like permission denied to `user` comes while pushig the code to \
github use following 
```bash
eval `ssh-agent -s`
ssh-add -L # lists all the keys
ssh-add ~/.ssh/<private-key-of-particular-acc>
```

## System Programming

Symbolic Links : symlinks provides an alternative name for a file. But whereas \
normal link is a filename-plus-pointer entry in a directory list
Filenames can be 255 chars long & cannot use / & \0(null char) in it.
File names cannot start with the - as it may be mistaken while passing in interpreter.
65 chars [-._a-zA-Z0-9] can be used while giving a name to a file.

## The *init* process

When booting the system, the kernel creates a special process called init, the \
parent of all processes, which is derieved from the program file /sbin/init.\
The init process always has the process ID 1 and runs with superuser previleges. \
The init process can't be killed & it terminates only when system is shutdown. \

## The Daemon Process

It's a special purpose process that is created and handled byt the system in the \
same way as other processes but has following characterstics:
- It's long lived. A daemon process is often started at system boot and remains \
in existence until the system is shut down.
- It runs in the background, and has no controlling terminal from which it can \
read input or to which it can write outpu.
eg. syslogd & httpd

## Resource limits

Each process consumes resources, such as open files, memory, & cpu time.
`setrlimit()` system call can establish upper limit on consumtion of resources \
for a process. Each resource limit has two associated values: a soft limit \
which limits the amount the process may consume  & a hard limit, which is ceiling \
on the value to which the soft limit may be extended.

## Memory mapping

`mmap()`
memory mapping is done on virutal memory to physical address


## Install inotify

`sudo apt install libinotifytool0-dev` This is package for notification popup

## Compress jpg using `jpegoptim`

Following will compress the output file to 1MB
`jpegoptim --size=1024k file.jpg`

## Compiling the Kernel

Tailoring the kernel to your system is by using `make localmodconfig`.
This options creates a configuration file based on the list of modules currently \
loaded on the system.
```
lsmod > /tmp/mymods
make LSMOD=/tmp/mymods localmodconfig
make -j`nproc`
```
