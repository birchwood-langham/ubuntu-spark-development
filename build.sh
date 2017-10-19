#!/usr/bin/env bash

# If we need to set proxy we need to pass the settings as build-args
# docker build \
# --build-arg no_proxy='localhost,127.0.0.0/8' \
# --build-arg proxyUser='username' \
# --build-arg proxyPass='password' \
# --build-arg http_proxy='http://username:password@proxy:port' \
# --build-arg https_proxy='http://username:password@proxy:port' \
# -t ubuntu-spark-dev:16.04 .

# We put this in the build script so that it doesn't download every single
# time if we have to rebuild. Also, we don't need to install wget in the container

docker build -t birchwoodlangham/ubuntu-spark-development:2017-10 .
