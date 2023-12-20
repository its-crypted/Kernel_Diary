#!/bin/bash

# RESET
CO='\033[0m'

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

echo -e "${BCyan}"
echo "+---------------------------------------------+"
cat >&2<< EOF
+----------------------------------------+
|	Updating & Upgrading packages	 |
+----------------------------------------+
EOF
echo -e "${CO}"
sudo apt -y update && sudo apt -y upgrade

function set_git {
	echo -e "${BPurple}"
	u_name=$(git config user.name)
	u_email=$(git config user.email)
	if [ u_name == "" && u_email == "" ]
	then
	echo -e "${BPurple}"
cat >&2<< EOF
+-------------------------------------------------+
| I : You don't have git global config  set	  |
|     Would you like to set the global user.name  |
|     & user.email				  |
+-------------------------------------------------+
EOF
	echo -e "${CO}"
	read -p "Enter[y/n]: " set_ne
	if [ set_ne == 'y' ]
	then
		read -p "Enter user.email for git: " MAIL
		read -p "Enter user.name for git: " NAME
	else
		continue
	fi
	fi
}

function set_ssh {
	read -p "Enter comment for \"ssk-keygen -C\"" SSH_C
}

CORE_COUNT=egrep -c '(vmx | svm)' /proc/cpuinfo
if [ $CORE_COUNT > 0 ]
then
	echo -e "${BGreen}---** Vitualization OK **---${CO}"
else
	echo -e "${BRed}"
	echo "Enable Virtualization in BIOS --> EXITING"
	echo -e "${CO}"
	exit 0
fi

function cd_up() {
    echo -e "
    #This is for the cd.. so that you can go to specified directory

    function cd_up() {
        case \$1 in
        *[!0-9]*)
            cd \$( pwd | sed -r \"s|(.*/\$1[^/]*/).*|\1|\" )
            ;;
        *)
            cd \$(printf \"%0.0s../\" \$(seq 1 \$1));
            ;;
        esac
    }
    alias 'cd..'='cd_up'

    " >> ~/.bashrc
}

function vi_() {
cat <<- EOF >> ~/.vimrc
syntax on
set title
set number
set cc=80
set autoindent
colorscheme delek
set columns=80
set mouse=a
set guioptions+=k
set guioptions-=L

set splitbelow
set splitright
set equalalways
set clipboard=unnamedplus

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
EOF
}

function kernel() {	
    sudo apt -y install vim git openssh-client libssl-dev \
		 linux-headers-`uname -r` build-essential \
		 dwarves zstd libelf-dev flex bison exuberant-ctags \
		 cscope git-email libncurses5-dev gcc make terminator \
	
	echo "Which Kernel you want to download? Currently the depth for dow
	downloading the kernel has been set to 3"
	echo "1. Mainline"
	echo "2. Stable"
	echo "3. Next"
	read -p "--> " k_num
	if [ k_num -eq 1 ]
	then 
		git clone --depth=3 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	elif [ k_num -eq 2 ]
	then
		git clone --depth=3 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
	elif [ k_num -eq 3 ]
	then 
		git clone --depth=3 git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
	else
		echo "Exiting -- Enter proper number"
		exit 0
	fi
}

function qemu() {
   	 sudo apt -y install kernel-package fakeroot ccache qemu \
         qemu-kvm qemu-system libvirt-daemon bridge-utils \
         virt-manager gdb

	sudo usermod -aG libvirt $USER 
	sudo usermod -aG kvm $USER

	sudo systemctl start libvirtd
	sudo systemctl enable libvirtd
}

function gengpg() {
	gpg --full-generate-keys
	gpg --list-secret-keys --keyid-format long
}

function main(){

cat >&2 << EOL
Setup tools
 1. Kernel
 2. Vim
 3. Git
 4. SSH
 5. QEMU
 6. ALL

EOL

	echo "Select what you want to setup"
	read -p "Enter number: " set_num

	if [ set_num = 1 ]
	then
		kernel
	elif [ set_num -eq 2 ]
	then
		vi_
	elif [ set_num -eq 3 ]
	then
		set_git
	elif [ set_num -eq 4 ]
	then
		set_ssh
	elif [ set_num -eq 5 ]
	then
		qemu
	elif [ set_num -eq 6 ]
	then
		kernel
		vi_
		set_git
		set_ssh
		qemu
	else
		exit 0;
	fi
}

main()	
