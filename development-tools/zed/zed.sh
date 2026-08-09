#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/import.sh"

smu::import base
smu::import system

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if ! is_debian; then
        error "This script is only for Debian!"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    apt_install_from_file "packages"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install Zed
    # see: https://zed.dev/docs/linux
    curl -fsSL https://zed.dev/install.sh | sh

}

main
