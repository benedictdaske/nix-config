{ config, outputs, pkgs, ... }:
{
  # documentation I use
  documentation = {
    enable = true;
    man.enable = true;
    info.enable = false;
    doc.enable = false;
  };

  environment = {
    # otherwise homebrew brews are not found
    extraInit = ''
      export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt:$PATH"
    '';
    systemPackages = with pkgs; [
      gitMinimal
      home-manager
      inetutils
      killall
      wget
    ];
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };
    shells = with pkgs; [ bashInteractive zsh fish ];
  };

  fonts = {
    packages = with pkgs; [
      fira-code
      jetbrains-mono
      meslo-lgs-nf
      monaspace
      noto-fonts-emoji

      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
    ];
  };

  # build environment
  # disabled to allow Determinate Nix to manage Nix
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
    # required from 25.05
    primaryUser = "brene";

    defaults = {
      alf = {
        # enable firewall
        globalstate = 1;
        # enable stealth mode, drop ICMP requests e.g. pings
        stealthenabled = 1;
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
        # disable desktop icons
        CreateDesktop = false;
        # TODO necessary ???
        _FXShowPosixPathInTitle = true;
        # enable column view for new windows
        FXPreferredViewStyle = "clmv";
        # new finder window opens in home directory
        NewWindowTarget = "Home";
        # bottom path bar
        ShowPathbar = true;
        # allow to quit finder
        QuitMenuItem = true;
      };

      # fn changes input language
      hitoolbox.AppleFnUsageType = "Do Nothing";

      loginwindow = {
        # disable guest account
        GuestEnabled = false;
      };

      NSGlobalDomain = {
        # 24-hour time
        AppleICUForce24HourTime = true;
        # dark mode
        AppleInterfaceStyle = "Dark";
        # file extensions
        AppleShowAllExtensions = true;
        # show scrollbars only when scrolling
        AppleShowScrollBars = "WhenScrolling";
        # diasable for key-repeat
        ApplePressAndHoldEnabled = false;

        # fast key repeat
        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 25; # Values: 120, 94, 68, 35, 25, 15

        # default: fn instead of actions
        "com.apple.keyboard.fnState" = true;
        # tap to click
        "com.apple.mouse.tapBehavior" = 1;
        # disable error sounds
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
        # natural scrolling
        "com.apple.swipescrolldirection" = true;


        # disable iCloud saving by default
        NSDocumentSaveNewDocumentsToCloud = false;

      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      # custom user preferences using plist code
      CustomUserPreferences = {

        # custom keybindings
        "com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
          "27" = {
            enabled = true;
            value = {
              parameters = [ 65535 48 524288 ];
              type = "standard";
            };
          };
          # Disable Ctrl+Space (Previous Input Source)
          "60".enabled = false;
          # Enable Ctrl+Option+Space (Next Input Source)
          "61".enabled = true;
          # Disable Cmd+Space (Spotlight Search)
          "64".enabled = false;
          # Disable Emoji Picker (Ctrl+Cmd+Space)
          "160".enabled = false;
          # Disable 2xFn for Dictation
          "164" = {
            enabled = false;
            value = {
              parameters = [ 65535 65535 0 ];
              type = "standard";
            };
          };
        };

      };
    };
  };


  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  # knownUsers & uid are required for fish to work as default shell.
  users = {
    knownUsers = [ "brene" ];
    users.brene = {
      home = "/Users/brene";
      shell = pkgs.fish;
      uid = 501;
    };
  };

  # fish is our default shell on Mac and we want to make sure that we're
  # configuring the rc correctly with nix-darwin paths.
  programs.fish.enable = true;
  programs.fish.shellInit = ''
    # Nix
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end
    # End Nix
  '';

  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
  '';

}
