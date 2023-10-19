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
