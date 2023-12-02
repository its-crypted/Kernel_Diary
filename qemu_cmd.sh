#!/bin/bash

qemu-system-x86_64 --enable-kvm -kernel main/arch/x86/boot/bzImage \
	-hda debian.img \
	-append "root=/dev/sda nokaslr" \
	-m 8g \ #Give memory of 8GB to the system
	-smp 4 \ #Simultaneous Multiprocessor 4
