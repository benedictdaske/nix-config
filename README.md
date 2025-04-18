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
#### 3. Initialize Template
#### 4. Make apps executable
``` shell
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f \( -name apply -o -name build -o -name build-switch -o -name create-keys -o -name copy-keys -o -name check-keys -o -name rollback \) -exec chmod +x {} \;
```


## Authorship

Part of this config was collected from other Nix configurations. Thanks to dustinlyons, [his config](https://github.com/dustinlyons/nixos-config) has been a great but challenging introduction to Nix.
