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
        shells = with pkgs; [ bashInteractive zsh fish ];
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

    # build environment
    nix = {
        enable = false;
        settings = {
            sandbox = "relaxed";
            extra-sandbox-paths = [
                "/private/var/db/oah" # aot files
                "/Library/Apple" # rossetta runtime
            ];
            trusted-users = [ "@admin" ];
        };
    };

    # enable in case sandbox is too strict
    # system.systemBuilderArgs = lib.mkIf (config.nix.settings.sandbox == "relaxed") {
    #     sandboxProfile = ''
    #         (allow file-read* file-write* process-exec mach-lookup (subpath "${builtins.storeDir}"))
    #     '';
    # };

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

    # default settings for darwin
    system = {
        defaults = {
            NSGlobalDomain = {
                # 24-hour time
                AppleICUForce24HourTime = true;
                # dark mode
                AppleInterfaceStyle = "Dark";
                # file extensions
                AppleShowAllExtensions = true;
                # diasable for key-repeat
                ApplePressAndHoldEnabled = false;

                # fast key repeat
                KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
                InitialKeyRepeat = 25; # Values: 120, 94, 68, 35, 25, 15

                # default: fn instead of actions
                "com.apple.keyboard.fnState" = true;
                # allow tap to click
                "com.apple.mouse.tapBehavior" = 1;
                # disable error sounds
                "com.apple.sound.beep.volume" = 0.0;
                "com.apple.sound.beep.feedback" = 0;
            };

            dock = {
                autohide = true;
                # magnified size
                largesize = 48;
                launchanim = true;
                magnification = true;
                minimize-to-application = true;
                orientation = "bottom";
                show-recents = false;
                tilesize = 32;
            };

            finder = {
                # TODO necessary ???
                _FXShowPosixPathInTitle = true;
                # enable column view for new windows
                FXPreferredViewStyle = "clmv";
                # bottom path bar
                ShowPathbar = true;
            };

            loginwindow = {
                # disable guest account
                GuestEnabled = false;
            };

            trackpad = {
                Clicking = true;
                TrackpadThreeFingerDrag = true;
            };
        };
    };


    # The user should already exist, but we need to set this up so Nix knows
    # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
    users = {
        knownUsers = [ "brene" ];
        users.brene = {
            home = "/Users/brene";
            shell = pkgs.fish;
            uid = 501;
        };
    };

    programs.fish.enable = true;
    programs.fish.shellInit = ''
        # Nix
        if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
        source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
        end
        # End Nix
    '';

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