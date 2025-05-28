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

        # formatting for nix files
        nix-formatter-pack.url = "github:Gerschtli/nix-formatter-pack";


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
    with inputs;
    let
        inherit (self) outputs;

        user = "brene";

        # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        stateVersion = "24.11";

        linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
        darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
        forAllSystems = func: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) func;

        libx = import ./lib { inherit inputs outputs stateVersion; };

    in
    libx.loadSystems // {
        # Devshell for bootstrapping; acessible via 'nix develop' or 'nix-shell' (legacy)
        devShells = libx.forAllSystems (system:
            let pkgs = nixpkgs.legacyPackages.${system};
            in import ./shell.nix { inherit pkgs; }
        );

        # nix fmt
        formatter = libx.forAllSystems (system:
            nix-formatter-pack.lib.mkFormatter {
                inherit nixpkgs system;
                config = {
                    tools = {
                        alejandra.enable = false;
                        deadnix.enable = true;
                        nixpkgs-fmt.enable = true;
                        statix.enable = true;
                    };
                };
            }
        );

        # Custom packages and modifications, exported as overlays
        overlays = import ./overlays { inherit inputs; };

        # For Custom packages; acessible via 'nix build', 'nix shell', etc
        # packages = libx.forAllSystems (system:
        #     let pkgs = nixpkgs.legacyPackages.${system};
        #     in import ./pkgs { inherit pkgs; inherit inputs; }
        # );

    };
}