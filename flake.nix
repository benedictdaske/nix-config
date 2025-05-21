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

        # disk partitioning
        # disko = {
        #     url = "github:nix-community/disko";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };


        # non-flakes e.g. nvim plugins
        # nvim-render-markdown = {
        #     url = "github:MeanderingProgrammer/render-markdown.nvim";
        #     flake = false;
        # }
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, ... }@inputs:
    let

        user = "brene";

        # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        stateVersion = "24.11";

        linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
        darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
        forAllSystems = func: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) func;

        libx = import ./lib { inherit inputs outputs stateVersion; };

    in
    {
        

        # Custom packages and modifications, exported as overlays
        overlays = import ./overlays { inherit inputs; };

    };
}