{ pkgs, self, ... }:
{
  imports = [
    # (myModulesPath + "/neovim")
  ];

  home.packages = with pkgs; [
    ascii
    # unstable.bitwarden
    btop
    caligula # OS img flashing
    cloudflared
    cmatrix
    unstable.codex
    # docker-client # check if docker cli works
    unstable.devenv
    gcc
    mas
    mosquitto # iotsec
    nix-diff
    nodejs_22
    # nodejs # Node is required for Copilot.vim
    # nodePackages.prettier
    ookla-speedtest
    
    # sops # pushing secrets via git
    whois

    starship
    uv
    zstd # compression
  ];
}
