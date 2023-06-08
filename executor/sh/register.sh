#!/usr/bin/env sh

role="$1"

# App installation tasks on a client node. Runs first
if [ "$role" = 'client' ]; then
    carburator print terminal info \
        "Executing install script on a client node"

    
fi

# App installation tasks on remote server node.
if [ "$role" = 'server' ]; then
    carburator print terminal info \
        "Executing install script on a server node"
fi

# If lua is present don't bother with the install
if ! carburator has program lua; then
    carburator print terminal warn \
        "Missing required program lua. Trying to install..."
else
    carburator print terminal success "Lua found from the $role"
    exit 0
fi

# TODO: Untested below
if carburator has program apt; then
    apt-get -y update
    apt-get -y install lua5.4

elif carburator has program pacman; then
    pacman update
    pacman -Sy lua

elif carburator has program yum; then
    yum makecache --refresh
    yum install epel-release
    yum install lua

elif carburator has program dnf; then
    dnf makecache --refresh
    dnf -y install lua

else
    carburator print terminal error \
        "Unable to detect package manager from client node linux"
    exit 120
fi
