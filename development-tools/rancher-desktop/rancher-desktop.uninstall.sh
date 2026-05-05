#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if ! is_debian; then
        error "This script is only for Debian!"
        return 1
    fi

    ask_for_sudo

    # Inverse of rancher-desktop.sh:
    # - remove the rancher-desktop package
    # - drop the apt source list and signing key added during install
    sudo apt-get remove --purge -y rancher-desktop &> /dev/null
    sudo rm -f /etc/apt/sources.list.d/isv-rancher-stable.list
    sudo rm -f /usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg
    sudo apt-get autoremove -qqy &> /dev/null
    sudo apt-get update &> /dev/null

}

main
