#!/usr/bin/env bash

set -eo pipefail

DOCTL_CHECKSUM=ea22347e8a578f9e4ef11f61c225b820dbcd9893c835150cecf495c5f552ec5b
DOCTL_VERSION=1.32.3

HELM_CHECKSUM=38614a665859c0f01c9c1d84fa9a5027364f936814d1e47839b05327e400bf55
HELM_VERSION=2.14.3

KUBECTL_CHECKSUM=fccf152588edbaaa21ca94c67408b8754f8bc55e49470380e10cf987be27495a8411d019d807df2b2c1c7620f8535e8f237848c3c1ac3791b91da8df59dea5aa
KUBECTL_VERSION=1.16.0

setup() {
    mkdir /lib64
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
    apk add --no-cache wget
}

teardown() {
    apk del wget
}

install_doctl() {
    wget https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz

    echo "${DOCTL_CHECKSUM}  doctl-${DOCTL_VERSION}-linux-amd64.tar.gz" > doctl.checksum
    sha256sum -c doctl.checksum
    rm doctl.checksum

    tar zxvf doctl-${DOCTL_VERSION}-linux-amd64.tar.gz
    mv doctl /usr/local/bin/doctl
    chmod +x /usr/local/bin/doctl

    rm -rf doctl-${DOCTL_VERSION}-linux-amd64.tar.gz
}

install_helm() {
    wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz

    echo "${HELM_CHECKSUM}  helm-v${HELM_VERSION}-linux-amd64.tar.gz" > helm.checksum
    sha256sum -c helm.checksum
    rm helm.checksum

    tar zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz
    mv linux-amd64/helm /usr/local/bin/helm
    chmod +x /usr/local/bin/helm
    
    rm -rf helm-v${HELM_VERSION}-linux-amd64.tar.gz linux-amd64
}

install_kubectl() {
    wget https://dl.k8s.io/v${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz

    echo "${KUBECTL_CHECKSUM}  kubernetes-client-linux-amd64.tar.gz" > kubectl.checksum
    sha512sum -c kubectl.checksum
    rm kubectl.checksum
    
    tar zxvf kubernetes-client-linux-amd64.tar.gz
    mv kubernetes/client/bin/kubectl /usr/local/bin/kubectl
    chmod +x /usr/local/bin/kubectl
    
    rm -rf kubernetes-client-linux-amd64.tar.gz kubernetes
}

setup
install_kubectl
install_helm
install_doctl
teardown
