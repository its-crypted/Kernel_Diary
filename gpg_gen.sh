#!/bin/bash

gpg --batch --full-generate-key ip.txt
PUB_KEY=`gpg --list-secret-keys --with-colons \
	| grep 'sec:' \
	| cut -d : -f 5 \
	| tail -1`

gpg --armor --export $PUB_KEY | xclip -sel clip
printf  "\v-----> Content Copied to Clipboard <-----\n"
