#!/bin/bash

kernel_version=$(uname -r)
read -p "Enter the path of kernel $kernel_version"$'\n' kpath
kpath=$(eval "echo $kpath")
kpath=$(realpath "$kpath")

usage() {
	cat <<EOF
Usage: $0 [OPTIONS]

Description:
	This is a setup script which will install all deps required for damon &
	builds and install the perf-tool for your custom kernel.

OPTIONS:
  -h, --help	Gives out info about how to use this file

EOF
}

perf_install() {
	cd $kpath
	if [ -d "tools/perf" ]; then
		cd tools/perf
		sudo make
		sudo make prefix=/usr/local install
		if [ $? = '0' ]; then
			echo "Perf `perf -v` has been installed for `uname -r` kernel"
		else
			"Perf isn't installed correctly"
			exit 0
		fi
	else
		echo "Path Doesn't exist something's wrong"
	fi
}

perf_deps() {

	sudo apt install libslang2-dev \
			 libcap-dev    \
			 libperl-dev   \
			 libbabeltrace-dev \
			 libpfm4-dev	\
			 libtraceevent-dev \
			 clang	\
			 asciidoc  \
			 pkg-config \
			 libnuma-dev \
			 libzstd-dev \
			 libpfm4-dev \
			 libunwind-dev \
			 systemtap-sdt-dev \
			 openjdk-8-jdk
}

perf_install
