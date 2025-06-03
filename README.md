# nix-config
My personal - hopefully - clean, modular and well-documented Nix config

## Structure
- ```apps``` contains executables for updating and installing the system
- ```hosts``` defines configs for my personal machines, as well as a ```shared``` one
- ```modules``` self-built modules for system management - yet to be added
- ```overlays``` allows to apply patches and version overrides
- ```pkgs``` contains self built packages, mainly sourced directly from GitHub


## Installation

### MacOS

#### 1. Dependencies
#### 2. Install Nix
I highly recommend using the Determinate Systems [nix-installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file) for a smooth setup process.

#### 3. Initialize Template
#### 4. Make apps executable
``` shell
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name apply -o -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys -o -name rollback \) -exec chmod +x {} \;
```


#### 5. Darwin fish
chsh -s /opt/homebrew/bin/fish


## Authorship

Part of this config was collected from other Nix configurations. Most notably, the configs of [dustinlyons](https://github.com/dustinlyons/nixos-config), [mitchellh](https://github.com/mitchellh/nixos-config) and [shayne](https://github.com/shayne/nixos-config) have been a great but challenging introduction to Nix. Please give their configs a look, these people actually know what they're doing...
