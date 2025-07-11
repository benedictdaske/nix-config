{ pkgs, myModulesPath, ... }:
{
  imports = [
    # (myModulesPath + "/neovim")
  ];

  home.packages = with pkgs; [
    ascii
    btop
    cmatrix
    # docker-client # check if docker cli works
    gcc
    nix-diff
    # nodejs # Node is required for Copilot.vim
    # nodePackages.prettier
    ookla-speedtest
    # sops # pushing secrets via git
    whois

    # unstable.devenv # maybe later ???
    unstable.starship
  ];
}