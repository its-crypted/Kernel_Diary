#!/bin/bash

qemu-system-x86_64 -enable-kvm \
-cdrom ./*.iso -boot order=d -drive file=deb.img \
-m 2G
