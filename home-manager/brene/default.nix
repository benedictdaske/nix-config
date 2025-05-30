{ config, lib, pkgs, sources, myModulesPath, ... }:

let
  inherit (pkgs.stdenv) isLinux;
in
{
  home.stateVersion = "25.05";

  imports = [
    # (myModulesPath + "/fish")
    # (myModulesPath + "/bash")
    # (myModulesPath + "/neovim")
    # (myModulesPath + "/ssh")
    # (myModulesPath + "/starship")
    # (myModulesPath + "/tree-sitter")
  ];

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  home.packages = with pkgs; [
    bat
    bind
    fd
    fzf
    gcc
    gnugrep
    htop
    jq
    nix-diff
    # nodejs # Node is required for Copilot.vim
    # nodePackages.prettier
    ookla-speedtest
    python3
    ripgrep
    # sops # pushing secrets via git
    tree
    # upterm # Terminal sharing
    watch
    whois
    zoxide

    # unstable packages
    # unstable.claude-code # needs license
  ] ++ (lib.optionals isLinux [
    # additional packages for linux only
    ramfetch
    traceroute
  ]);

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_GB.UTF-8";
    LC_CTYPE = "en_GB.UTF-8";
    LC_ALL = "en_GB.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "${pkgs.bat}/bin/bat -l man -p";
  };

  # TODO move to dotfiles
  # Prevent the "Last login" message from showing up
  home.file.".hushlogin".text = "";

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
    config = {
      whitelist = {
        exact = [ "$HOME/.envrc" ];
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "benedictdaske";
    userEmail = "benedictdaske@tutanota.com";
    aliases = {
    #   cleanup = "!git branch --merged | grep -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
    #   prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    #   root = "rev-parse --show-toplevel";
    #   amend = "commit --amend --no-edit";
    };
    diff-so-fancy.enable = true;
    extraConfig = {
      color.ui = true;
      github.user = "benedictdaske";
      init.defaultBranch = "main";
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