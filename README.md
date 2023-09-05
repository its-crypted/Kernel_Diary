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

`linux/Kconfig` is the main file for `menuconfig` the general setup config starts from here.
Every dir has it's own `kconfig` file which is source form `Kconfig`
