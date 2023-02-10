FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y python3 python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache snap-stanford
