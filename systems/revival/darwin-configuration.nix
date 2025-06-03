{ config, lib, ... }: {
    nixpkgs.hostPlatform = "aarch64-darwin";

    # m2 macbook pro
    networking.hostName = "revival";

    # enable touch id for sudo

    # security.pam.enableSudoTouchIdAuth = true;
    # security.pam.services.sudo_local.touchIdAuth = true;

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

        brews = [
            "fisher"
            "ascii"
        ];
        taps = [];
        casks = [
            "ghostty"
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

        defaults.dock = {
            persistent-apps = [
                "/Applications/Ghostty.app"
            ];
        };
    };
}