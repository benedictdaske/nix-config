{ pkgs, myModulesPath, ... }:
{
  imports = [
    # (myModulesPath + "/rectangle")
  ];

  home.packages = with pkgs; [
    btop
    # docker-client # check if docker cli works
    gcc
    nix-diff
    # nodejs # Node is required for Copilot.vim
    # nodePackages.prettier
    ookla-speedtest
    python3
    # sops # pushing secrets via git
    whois

    # unstable.devenv # maybe later ???
  ];
}