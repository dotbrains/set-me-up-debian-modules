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

    # Zed's official installer ships an uninstall mode.
    # see: https://zed.dev/docs/linux
    if cmd_exists "curl"; then
        curl -fsSL https://zed.dev/install.sh | sh -s -- --uninstall
    else
        # Fallback: the installer drops Zed under ~/.local. Strip the bits we
        # know about; the user can rerun the official uninstaller later.
        rm -rf "$HOME/.local/zed.app"
        rm -f "$HOME/.local/bin/zed"
        rm -f "$HOME/.local/share/applications/dev.zed.Zed.desktop"
    fi

}

main
