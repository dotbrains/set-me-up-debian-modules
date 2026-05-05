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

    # Inverse of fira-code.sh: delete the FiraCode Nerd Font files dropped
    # under the user's font dir, then refresh the font cache.
    local fonts_dir="${HOME}/.local/share/fonts"

    if [[ -d "$fonts_dir" ]]; then
        find "$fonts_dir" -maxdepth 1 -name 'FiraCode*' -delete
    fi

    if cmd_exists "fc-cache"; then
        fc-cache -fv > /dev/null
    fi

}

main
