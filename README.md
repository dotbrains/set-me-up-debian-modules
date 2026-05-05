# 'set-me-up' Debian Modules

[![License: PolyForm Shield 1.0.0](https://img.shields.io/badge/License-PolyForm%20Shield%201.0.0-blue.svg)](https://polyformproject.org/licenses/shield/1.0.0/)

This repository contains granular Debian/Linux modules for the [`set-me-up`](https://github.com/dotbrains/set-me-up) project.

## Structure

Each module is organized by category with per-package subdirectories:

```
debian/
├── browsers/
│   ├── chrome/
│   └── firefox/
├── cloud-sync/
│   └── insync/
├── development-tools/
│   ├── code/
│   ├── cursor/
│   ├── gitkraken/
│   ├── insomnia/
│   ├── jetbrains-toolbox/
│   ├── rancher-desktop/
│   └── zed/
├── fonts/
│   ├── fira-code/
│   └── jetbrains-mono/
├── media/
│   └── spotify/
├── security/
│   ├── 1password/
│   └── nordvpn/
└── terminal/
    ├── terminator/
    └── warp/
```

## Module kinds

Each module directory contains one of:

- **`packages`** — most common. A small DSL parsed by `apt_install_from_file` that declares `apt`, `deb`, `snap`, `ppa`, `gpg`, and `source` directives. Reversed declaratively by `apt_remove_from_file`.
- **`<name>.sh`** — used when an install can't be expressed as `packages` alone (custom apt repos with signing keys, vendor installer scripts, font downloads, etc.). Most `*.sh` modules ship a sibling `packages` file too: the install script handles the bespoke setup, the `packages` file declares shared dependencies. See `development-tools/cursor/`, `security/nordvpn/`, `fonts/fira-code/`.

The `smu` installer resolves a module by name and runs whichever artifact it finds. See the [installer README](https://github.com/dotbrains/set-me-up-installer#discovering-modules) for the full module-resolution rules and the `-p` / `-i` / `-l` flags.

## OS guarding

These modules are Debian-only. Defense-in-depth is layered so that running them on macOS or any non-Debian host fails closed:

1. **Top-level `install.sh`** — checks `is_debian` once and then iterates every `packages` file under this tree via `apt_install_from_file`. Use this as the single entry point when bulk-installing the whole module set.
2. **`smu` orchestrator guard** — `smu` refuses to provision or uninstall a `packages` module on a non-Debian host with a clear warning, even when targeted directly via `-m`.
3. **Per-script guard** — every `*.sh` module calls `is_debian` at the top of `main()` and bails with an error message otherwise.

(`packages` files use a custom DSL parsed by `apt_install_from_file` rather than a programming language, so a per-file inline guard analogous to brewfile's `abort unless OS.mac?` isn't possible — the orchestrator-level guards in (1) and (2) are the closest equivalent.)

## Auditing and uninstalling

The `smu` installer ships read-only auditing (`smu --status`) and reversal (`smu --uninstall`) for every module:

```bash
smu --status                                    # what's currently installed
smu --status -V                                 # verbose: per-entry detail
smu -u -m development-tools/cursor              # uninstall (prompts [y/N])
smu -iu                                         # interactive uninstall via fzf
```

For `packages` modules detection and uninstall are automatic — each declared entry is queried via `dpkg -s` / `snap list` / `sources.list.d` lookups, and `apt_remove_from_file` reverses the install. `smu --status` reports `partial` when only some entries are present (e.g. an `apt` package was uninstalled by hand but the gpg keyring is still around).

For `*.sh` modules `smu` only acts when the module ships two opt-in sibling files:

- **`<name>.installed`** — sourced by `smu --status`. Exit 0 means installed; non-zero means missing. Without this file, the module reports `unknown` (smu never guesses).
- **`<name>.uninstall.sh`** — sourced by `smu --uninstall`. Without this file, the module is reported as "cannot auto-uninstall — manual cleanup required" and skipped.

If a `*.sh` module shares its directory with a `packages` file (the common case in this tree), `smu --uninstall` runs **both** inverses in order: the per-module `<name>.uninstall.sh` first (apt repo, signing key, the named package, vendor dirs), then `apt_remove_from_file packages` (shared dependencies declared in the `packages` file). Each uninstaller therefore only undoes what *its* install script added — never the packages-file deps — so they compose cleanly.

The seven custom-script modules in this tree (`cursor`, `zed`, `jetbrains-toolbox`, `rancher-desktop`, `nordvpn`, `fira-code`, `jetbrains-mono`) all ship `<name>.installed` and `<name>.uninstall.sh` siblings and are fully reversible. See the [installer README](https://github.com/dotbrains/set-me-up-installer#auditing-whats-installed) for the full status/uninstall reference and authoring examples.

## Usage

These modules are designed to be used as submodules within the [`set-me-up` blueprint](https://github.com/dotbrains/set-me-up-blueprint) repository.

## License

This project is licensed under the [PolyForm Shield License 1.0.0](https://polyformproject.org/licenses/shield/1.0.0/) — see [LICENSE](LICENSE) for details.