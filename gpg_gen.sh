#!/bin/bash

gpg --batch --full-generate-key ip.txt
SEC_KEY=`gpg --list-secret-keys --with-colons \
	| grep 'sec:' \
	| cut -d : -f 5 \
	| tail -1`

gpg --armor --export $SEC_KEY
