#!/bin/bash

qemu-system-x86_64 --enable-kvm -kernel main/arch/x86/boot/bzImage \
	-hda debian.img \
	-append "root=/dev/sda nokaslr"
