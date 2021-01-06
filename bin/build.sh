#!/usr/bin/env bash

set -eo pipefail

DOCTL_CHECKSUM=e555f0ec407703b0f9d1d8c226304370bceb5b8898675b6011d8bfb9000e64ec
DOCTL_VERSION=1.54.0

HELM_2_CHECKSUM=7eebaaa2da4734242bbcdced62cc32ba8c7164a18792c8acdf16c77abffce202
HELM_2_VERSION=2.16.1

HELM_3_CHECKSUM=10e1fdcca263062b1d7b2cb93a924be1ef3dd6c381263d8151dd1a20a3d8c0dc
HELM_3_VERSION=3.0.0

KUBECTL_CHECKSUM=fccf152588edbaaa21ca94c67408b8754f8bc55e49470380e10cf987be27495a8411d019d807df2b2c1c7620f8535e8f237848c3c1ac3791b91da8df59dea5aa
KUBECTL_VERSION=1.16.0

SKAFFOLD_CHECKSUM=f2d876e60cfc0dfb0fc79263bc9900e9c08a8300bf1e4b2bbfef3f9936cc78e0
SKAFFOLD_VERSION=0.40.0

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

install_helm_2() {
    wget https://get.helm.sh/helm-v${HELM_2_VERSION}-linux-amd64.tar.gz

    echo "${HELM_2_CHECKSUM}  helm-v${HELM_2_VERSION}-linux-amd64.tar.gz" > helm.checksum
    sha256sum -c helm.checksum
    rm helm.checksum

    tar zxvf helm-v${HELM_2_VERSION}-linux-amd64.tar.gz
    mv linux-amd64/helm /usr/local/bin/helm2
    chmod +x /usr/local/bin/helm2
    
    rm -rf helm-v${HELM_2_VERSION}-linux-amd64.tar.gz linux-amd64
}

install_helm_3() {
    wget https://get.helm.sh/helm-v${HELM_3_VERSION}-linux-amd64.tar.gz

    echo "${HELM_3_CHECKSUM}  helm-v${HELM_3_VERSION}-linux-amd64.tar.gz" > helm.checksum
    sha256sum -c helm.checksum
    rm helm.checksum

    tar zxvf helm-v${HELM_3_VERSION}-linux-amd64.tar.gz
    mv linux-amd64/helm /usr/local/bin/helm
    chmod +x /usr/local/bin/helm
    
    rm -rf helm-v${HELM_3_VERSION}-linux-amd64.tar.gz linux-amd64
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

install_skaffold() {
    wget https://github.com/GoogleContainerTools/skaffold/releases/download/v${SKAFFOLD_VERSION}/skaffold-linux-amd64

    echo "${SKAFFOLD_CHECKSUM}  skaffold-linux-amd64" > skaffold.checksum
    sha256sum -c skaffold.checksum
    rm skaffold.checksum

    mv skaffold-linux-amd64 /usr/local/bin/skaffold
    chmod +x /usr/local/bin/skaffold
}

setup
install_kubectl
install_helm_2
install_helm_3
install_doctl
install_skaffold
teardown
