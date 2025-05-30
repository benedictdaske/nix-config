{ config, lib, inputs, outputs, pkgs, ... }:
{
    # documentation I use
    documentation = {
        enable = true;
        man.enable = true;
        info.enable = false;
        doc.enable = false;
    };

    environment = {
        systemPackages = with pkgs; [
            gitMinimal
            home-manager
            inetutils
            killall
            wget
        ];
        variables = {
            EDITOR = "vim";
            SYSTEMD_EDITOR = "vim";
            VISUAL = "vim";
        };
        shells = with pkgs; [ bashInteractive zsh ];
    };

    fonts = {
        packages = with pkgs; [
            (nerdfonts.override { fonts = [ "FiraCode" ]; })
            fira
            jetbrains-mono
            meslo-lgs-nf
            monaspace
            noto-fonts-emoji
        ];
    };

    nixpkgs = {
        # You can add overlays here
        overlays = [
            # Add overlays your own flake exports (from overlays and pkgs dir):
            # inputs.nixos-apple-silicon.overlays.apple-silicon-overlay

            # advanced future overlays
            # outputs.overlays.additions
            # outputs.overlays.modifications
            outputs.overlays.unstable-packages

            # Or define it inline, for example:
            # (final: prev: {
            #   hi = final.hello.overrideAttrs (oldAttrs: {
            #     patches = [ ./change-hello-to-hi.patch ];
            #   });
            # })
        ];

        # Configure your nixpkgs instance
        config = {
            # Disable if you don't want unfree packages
            allowUnfree = true;
        };
    };

    # The user should already exist, but we need to set this up so Nix knows
    # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
    users.users.shayne = {
        home = "/Users/shayne";
        shell = pkgs.zsh;
    };

    # zsh is the default shell on Mac and we want to make sure that we're
    # configuring the rc correctly with nix-darwin paths.
    programs.zsh.enable = true;
    programs.zsh.shellInit = ''
        # Nix
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
            . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
        # End Nix
    '';

}