#!/bin/bash

sudo make -j`nproc`
sudo make prefix=/usr/local/ install
