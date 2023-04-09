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
    exit
fi

# TODO: Untested below
if carburator has program apt; then
    carburator sudo apt update
    carburator sudo apt -y install lua5.4

elif carburator has program pacman; then
    carburator sudo pacman update
    carburator sudo pacman -Suy lua

elif carburator has program yum; then
    carburator sudo yum makecache --refresh
    carburator sudo yum install epel-release
    carburator sudo yum install lua

elif carburator has program dnf; then
    carburator sudo dnf makecache --refresh
    carburator sudo dnf -y install lua

else
    carburator print terminal error \
        "Unable to detect package manager from client node linux"
    exit 120
fi
