# nix-config
My personal - hopefully - clean, modular and well-documented Nix config


## Structure
```
.
├── home-manager # user specific config managed by home-manager
├── lib          # system building utilities, merging all configuration
├── modules      # advanced package configurations
├── overlays     # allows to apply patches or customisation, provides unstable channel
├── systems      # system configs for each machine
```

## Installation

### MacOS

#### 1. Install Dependencies (git)
``` sh
xcode-select --install
```
Or just try to use git (clone), an installation window should pop up.

#### 2. Install Nix
I highly recommend using the Determinate Systems [nix-installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file) for a smooth setup process. Since February 2025 Determinate Nix [officially supports](https://determinate.systems/posts/nix-darwin-updates/) nix-darwin.

#### 3. Clone Repo
The usual (:
``` sh
git clone https://github.com/benedictdaske/nix-config.git
```
``` sh
git clone git@github.com:benedictdaske/nix-config.git
```

#### 4. Build and Switch
To **build** a configuration:
``` sh
nix build ".#darwinConfigurations.HOSTNAME.system"
```
When the build has finished successfully, **switch** to the new config:
``` sh
./result/sw/bin/darwin-rebuild switch --flake ".#HOSTNAME"
```
Remember to replace ```HOSTNAME``` to equal the name of the desired config.

#### 5. Add Dotfiles to load customisation
Clone the dotfile repo of your choice to add your user customisation. I am using [my personal one](https://github.com/benedictdaske/dotfiles).
``` sh
git clone https://github.com/benedictdaske/dotfiles.git
```
``` sh
git clone git@github.com:benedictdaske/dotfiles.git
```

### Notes to self

<details><summary>1. Installing fisher</summary>
- [fisher](https://github.com/jorgebucaran/fisher) is a plugin manager for fish. Only needed if not yet in dotfiles.
``` sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```
</details>

#### Installing LazyVim
[LazyVim](https://github.com/LazyVim/LazyVim) is my preferred nvim config that saves me a lot of hassle. Only needed if not yet in dotfiles.
``` sh
git clone https://github.com/LazyVim/starter ~/.config/nvim
```
Remove ```.git``` folder:
``` sh
rm -rf ~/.config/nvim/.git
```


## Authorship

Part of this config was collected from other Nix configurations. Most notably, the config of [shayne](https://github.com/shayne/nixos-config) provided great insights into more complex Nix builds. While [dustinlyons](https://github.com/dustinlyons/nixos-config) config allowed me to test Nix for the first time without a hassle. Please give their configs a look, unlike me these people actually know what they're doing...