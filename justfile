# Build the system config and switch to it when running `just` with no args
default: switch

# colored output
RED    := '\033[1;31m'
YELLOW := '\033[0;33m'
GREEN  := '\033[0;32m'
NC     := '\033[0m'

# either arg or fallback to system if already set
hostname ?= `hostname -s`


### macos
# Build the nix-darwin system configuration without switching to it
[macos]
build target_host=hostname flags="":
  @echo "${YELLOW}Building nix-darwin config...${NC}"
  nix build ".#darwinConfigurations.{{target_host}}.system" {{flags}}
  @echo "${GREEN}Build completed!${NC}"

# Build the nix-darwin config with the --show-trace flag set
[macos]
trace target_host=hostname: (build target_host "--show-trace")

# Build the nix-darwin configuration and switch to it
[macos]
switch target_host=hostname: (build target_host)
  @echo "${YELLOW}Switching to new config for {{target_host}}...${NC}"
  ./result/sw/bin/darwin-rebuild switch --flake ".#{{target_host}}"
  @echo "${GREEN}Switched to new config!${NC}"


### linux
# Build the NixOS configuration without switching to it
[linux]
build target_host=hostname flags="":
	nixos-rebuild build --flake .#{{target_host}} {{flags}}

# Build the NixOS config with the --show-trace flag set
[linux]
trace target_host=hostname: (build target_host "--show-trace")

# Build the NixOS configuration and switch to it.
[linux]
switch target_host=hostname:
  sudo nixos-rebuild switch --flake .#{{target_host}}


# Update flake inputs to their latest revisions
update:
  nix flake update


# Garbage collect old OS generations and remove stale packages from the nix store
gc generations="5":
  nix-env --delete-generations {{generations}}
  nix-store --gc