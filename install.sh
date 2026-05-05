#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    if ! is_debian; then
        error "These modules are only for Debian-based systems!"
        return 1
    fi

    ask_for_sudo

    while IFS= read -r -d '' packages_file; do
        (
            cd "$(dirname "$packages_file")" &&
                apt_install_from_file "$(basename "$packages_file")"
        )
    done < <(find . -type f -name "packages" -print0)

}

main
