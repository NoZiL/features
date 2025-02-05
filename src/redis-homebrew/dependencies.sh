#!/usr/bin/env bash
# This code was generated by the devconainer-contrib cli 
# For more information: https://github.com/devcontainers-contrib/cli 

set -e

ensure_curl () {
    if ! type curl >/dev/null 2>&1; then
        apt-get update -y && apt-get -y install --no-install-recommends curl ca-certificates
    fi 
}


ensure_featmake () {
    if ! type featmake > /dev/null 2>&1; then
        temp_dir=/tmp/featmake-download
        mkdir -p $temp_dir

        curl -sSL -o $temp_dir/featmake https://github.com/devcontainers-contrib/cli/releases/download/v0.0.19/featmake 
        curl -sSL -o $temp_dir/checksums.txt https://github.com/devcontainers-contrib/cli/releases/download/v0.0.19/checksums.txt

        (cd $temp_dir ; sha256sum --check --strict $temp_dir/checksums.txt)

        chmod a+x $temp_dir/featmake
        mv -f $temp_dir/featmake /usr/local/bin/featmake

        rm -rf $temp_dir
    fi
}

ensure_curl

ensure_featmake

# refresh PATH 
PS1='\s-\v\$' source /etc/profile

# installing ghcr.io/devcontainers-contrib/features/homebrew-package:1.0.1
featmake "ghcr.io/devcontainers-contrib/features/homebrew-package:1.0.1" -PACKAGE "redis" -VERSION "$VERSION" 

