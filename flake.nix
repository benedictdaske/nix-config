{
    description = "Nix system configuration optimised for Darwin using Mac";

    inputs = {
        # primary nixpkgs repo
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

        # unstable repo for selected packages
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        # nix-darwin for MacOS
        nix-darwin = {
            url = "github:LnL7/nix-darwin/nix-darwin-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
        homebrew-core = { url = "github:homebrew/homebrew-core"; flake = false; };
        homebrew-cask = { url = "github:homebrew/homebrew-cask"; flake = false; };
        homebrew-bundle = { url = "github:homebrew/homebrew-bundle"; flake = false; };

        # home-manager for user config
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = { nixpkgs, ... }@inputs:
}