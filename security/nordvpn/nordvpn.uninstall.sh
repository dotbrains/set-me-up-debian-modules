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

    # NordVPN's installer drops both 'nordvpn' (the client) and
    # 'nordvpn-release' (which configures the apt repo). Remove both,
    # then strip the source list it added.
    # see: https://support.nordvpn.com/hc/en-us/articles/20196733641873
    sudo apt-get remove --purge -y nordvpn nordvpn-release &> /dev/null
    sudo rm -f /etc/apt/sources.list.d/nordvpn.list
    sudo apt-get autoremove -qqy &> /dev/null
    sudo apt-get update &> /dev/null

}

main
