{ config, lib, ... }: {
    nixpkgs.hostPlatform = "aarch64-darwin";

    # m2 macbook pro
    networking.hostName = "borderline";

    # enable touch id for sudo
    # deprecated ?
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

        brews = [];
        taps = [];
        casks = [

            "aldente"
            "bitwarden"
            "brave-browser"
            "ghostty"
            "freetube"
            "karabiner-elements"
            "obsidian"
            "onyx"
            "orbstack"
            "raycast"
            "spotify"
            "stats"
            "sublime-text"
            "syncthing"
            "telegram"
            "tuta-mail"
            "utm"
            "visual-studio-code"


            # add some of these ???
            # "bartender"
            # "cursor"
            # "deskpad"

            # "lunar"
            # "pearcleaner"
            # "rectangle"

            # "shortcat"
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
                # "/Applications/Visual\ Studio\ Code.app/"
                "/Applications/Visual Studio Code.app/"
                # "/Applications/Brave\ Browser.app"
                "/Applications/Brave Browser.app"
                # "/Applications/Tuta\ Mail.app/"
                "/Applications/Tuta Mail.app/"
            ];
        };
    };
}