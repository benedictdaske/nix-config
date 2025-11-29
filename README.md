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

>[!NOTE]
> My Nix config does not manage my dotfiles. 
> 
> All program customisation is managed by my dotfiles repo.



>[!IMPORTANT]
> This is my personal configuration. It can be used as a plug-and-play solution for Nix Darwin on MacOS machines running Sequoia. Some settings will need to be changed before using the configuration.
<!-- > This is my personal configuration. It is not designed to be a plug-and-play solution for any other system, though most parts should work work on any Mac. -->
>
> I recommend understanding and adapting the codebase to your needs before using it yourself.

## Installation

### MacOS

#### 1. Install Dependencies (git)
``` sh
xcode-select --install
```
Or just try to use git (clone), an installation window should pop up.

#### 2. Install Nix
I highly recommend using the Determinate Systems [nix-installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file) for a smooth setup process. Since February 2025 Determinate Nix [officially supports](https://determinate.systems/posts/nix-darwin-updates/) nix-darwin. In short:
``` sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
```

#### 3. Install Homebrew
The manual Homebrew is required, otherwise the switch will fail, asking you to install Homebrew.
``` sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 4. Clone Repo
The usual (:
``` sh
git clone https://github.com/benedictdaske/nix-config.git
```
``` sh
git clone git@github.com:benedictdaske/nix-config.git
```

#### 5. Build and Switch
To **build** a configuration:
``` sh
nix build ".#darwinConfigurations.HOSTNAME.system"
```
When the build has finished successfully, **switch** to the new config:
``` sh
./result/sw/bin/darwin-rebuild switch --flake ".#HOSTNAME"
```
Remember to replace ```HOSTNAME``` to equal the name of the desired config.

#### 6. Add Dotfiles to load customisation
Clone the dotfile repo of your choice to add your user customisation. I am using [my personal one](https://github.com/benedictdaske/dotfiles).
``` sh
git clone https://github.com/benedictdaske/dotfiles.git
```
``` sh
git clone git@github.com:benedictdaske/dotfiles.git
```

### Notes to self

#### 1. Installing fisher
[fisher](https://github.com/jorgebucaran/fisher) is a plugin manager for fish. Only needed if not yet in dotfiles.
``` sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

#### Installing LazyVim
[LazyVim](https://github.com/LazyVim/LazyVim) is my preferred nvim config that saves me a lot of hassle. Only needed if not yet in dotfiles.
``` sh
git clone https://github.com/LazyVim/starter ~/.config/nvim
```
Remove ```.git``` folder:
``` sh
rm -rf ~/.config/nvim/.git ~/.config/nvim/.gitignore
```

<details>
<summary> Temporary Reference </summary>

- https://github.com/edheltzel/dotfiles
- https://github.com/CoreyMSchafer/dotfiles
- https://github.com/mathiasbynens/dotfiles
- https://gitlab.com/dwt1/dotfiles
- https://github.com/omerxx/dotfiles
- https://github.com/mitchellh/nixos-config/blob/main/users/mitchellh/ghostty.linux

</details>


## Acknowledgements

Part of this config was collected from other Nix configurations. Most notably, the config of [shayne](https://github.com/shayne/nixos-config) provided great insights into more complex Nix builds. While [dustinlyons](https://github.com/dustinlyons/nixos-config) config allowed me to test Nix for the first time without a hassle. Please give their configs a look, unlike me these people actually know what they're doing...
