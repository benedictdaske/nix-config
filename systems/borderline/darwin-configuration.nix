{ config, lib, ... }: {
    nixpkgs.hostPlatform = "aarch64-darwin";

    # m2 macbook pro
    networking.hostName = "borderline";

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
        }
    }

    # enable touch id for sudo
    # deprecated ?
    security.pam.enableSudoTouchIdAuth = true;
    # security.pam.services.sudo_local.touchIdAuth = true;

    # enable in case sandbox is too strict
    # system.systemBuilderArgs = lib.mkIf (config.nix.settings.sandbox == "relaxed") {
    #     sandboxProfile = ''
    #         (allow file-read* file-write* process-exec mach-lookup (subpath "${builtins.storeDir}"))
    #     '';
    # };

        # local nix-index, research this, how to use?
    # programs.nix-index.enable = true;

    homebrew = {
        enable = true;

        onActivation = {
            cleanup = "zap";

            # enables cask updates on build-switch
            autoUpdate = true;
            upgrade = true;
        };
        # update on manual brew commands
        global.autoUpdate = true;

        brews = [];
        taps = [];
        casks = [
            # "arc"
            # "anytype"
            # "audacity"
            # "bambu-studio"
            # "bartender"
            # "bentobox"
            # "chatgpt"
            # "claude"
            # "cursor"
            # "deskpad"
            # "discord"
            # "diffusionbee"
            # "google-chrome"
            # "grammarly-desktop"
            # "homerow"
            # "inkscape"
            # "iterm2"
            # "linearmouse"
            # "lunar"
            # "microsoft-remote-desktop"
            # "multipass"
            # "ollama"
            # "orbstack"
            # "pearcleaner"
            # "raycast"
            # "screen-studio"
            # "shortcat"
            # "shureplus-motiv"
            # "signal"
            # "slack"
            # "stats"
            # "steam"
            # "swiftformat-for-xcode"
            # "syncthing"
            # "tailscale"
            # This freezes on quit, using desktop.telegram.org for now
            # "telegram-desktop"
            # "utm"
            # "visual-studio-code"
            # "vlc"
        ];
        # These app IDs are from using the mas CLI app
        # mas = mac app store
        # https://github.com/mas-cli/mas
        #
        # $ nix shell nixpkgs#mas
        # $ mas search <app name>
        masApps = {
            # "blackmagic-disk-speed-test" = 425264550;
            # "keynote" = 409183694;
            # "numbers" = 409203825;
            # "pages" = 409201541;
        };
    };

    system = {
        stateVersion = 6;

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
}