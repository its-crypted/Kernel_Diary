#!/bin/bash

qemu-system-x86_64 --enable-kvm -kernel main/arch/x86/boot/bzImage \
	-hda debian.img \
	-append "root=/dev/sda nokaslr console=ttyS0" \
	-m 8g \ #Give memory of 8GB to the system
	-smp 4 \ #Simultaneous Multiprocessor 4
	-serial stdio \ # This will output the boot output & only open loging window
	-display none \ # This will dump all the content on the current terminal
