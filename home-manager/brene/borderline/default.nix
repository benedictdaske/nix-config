{ pkgs, ... }:
{
  imports = [
    # (myModulesPath + "/neovim")
  ];

  home.packages = with pkgs; [
    # android-tools
    ascii
    btop
    caligula # OS img flashing
    cloudflared
    cmatrix
    # docker-client # check if docker cli works
    gcc
    mas
    nix-diff
    nodejs_22
    # nodejs # Node is required for Copilot.vim
    # nodePackages.prettier
    ookla-speedtest
    # sops # pushing secrets via git
    whois

    # unstable.devenv # maybe later ???
    unstable.starship
    zstd # compression
  ];
}
