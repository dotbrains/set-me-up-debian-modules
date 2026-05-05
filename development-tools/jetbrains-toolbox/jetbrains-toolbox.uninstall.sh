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

    # The third-party installer drops a versioned dir under /opt and a
    # symlink at /opt/jetbrains-toolbox plus a .desktop entry under the
    # user's local share dir. Remove all of them.
    sudo rm -rf /opt/jetbrains-toolbox*
    rm -f "$HOME/.local/share/applications/jetbrains-toolbox.desktop"
    rm -rf "$HOME/.local/share/JetBrains/Toolbox" 2>/dev/null

    # Project-installed dependency packages (libfuse2, libxi6, ...) are
    # widely used elsewhere — leave them in place to avoid breaking
    # unrelated software.

}

main
