#!/bin/bash

octet=$1


for i in {1..254}; do ping -c 1 -W 1 $octet.$i; done | grep "64 bytes" | cut -d ' ' -f 4 | tr -d : | sort -u &

