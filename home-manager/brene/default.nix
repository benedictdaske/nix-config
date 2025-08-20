{ lib, pkgs, ... }:

let
  inherit (pkgs.stdenv) isLinux;
in
{
  home.stateVersion = "25.05";

  imports = [
    # (myModulesPath + "/neovim")
  ];

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  home.packages = with pkgs; [
    bat
    bind
    curl
    fd
    fish
    fzf
    git
    gnugrep
    htop
    jq
    just
    neofetch
    neovim
    ripgrep
    stow
    tree
    # upterm # Terminal sharing
    watch
    yazi
    zoxide

    # unstable packages
    # unstable.claude-code # needs license...

  ] ++ (lib.optionals isLinux [
    # additional packages for linux only
    ramfetch
    traceroute
  ]);

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  # seem not to work???
  home.sessionVariables = {
    LANG = "en_GB.UTF-8";
    LC_CTYPE = "en_GB.UTF-8";
    LC_ALL = "en_GB.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "${pkgs.bat}/bin/bat -l man -p";
    STARSHIP_CONFIG = "/Users/brene/.config/starship/starship.toml";
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  #   programs.tmux = {
  #     enable = true;
  #     terminal = "xterm-256color";
  #     shortcut = "a";
  #     secureSocket = false;

  #     extraConfig = ''
  #       set -ga terminal-overrides ",*256col*:Tc"

  #       set -g @dracula-show-battery false
  #       set -g @dracula-show-network false
  #       set -g @dracula-show-weather false

  #       bind -n C-k send-keys "clear"\; send-keys "Enter"

  #       run-shell ${sources.tmux-pain-control}/pain_control.tmux
  #       run-shell ${sources.tmux-dracula}/dracula.tmux
  #     '';
  #   };
}
