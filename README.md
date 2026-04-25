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
│   ├── macports/
│   ├── rancher-desktop/
│   ├── xcode/
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

## Usage

These modules are designed to be used as submodules within the [`set-me-up` blueprint](https://github.com/dotbrains/set-me-up-blueprint) repository.

## License

This project is licensed under the [PolyForm Shield License 1.0.0](https://polyformproject.org/licenses/shield/1.0.0/) — see [LICENSE](LICENSE) for details.