#!/bin/bash

# first arg is the directory to put files
cd $1

if [ ! -f VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle ]; then
  curl -L -o VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle "https://www.dropbox.com/s/n5pepfatetp55q2/VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle?dl=1"
fi

if [ ! -f xenial-server-cloudimg-amd64.ova ]; then
  curl -L -o xenial-server-cloudimg-amd64.ova https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64.ova
fi

if [ ! -f xenial-server-cloudimg-arm64.ova ]; then
  curl -L -o xenial-server-cloudimg-arm64.ova https://s3-us-west-2.amazonaws.com/skyway-dl/xenial-server-cloudimg-arm64.ova
fi
