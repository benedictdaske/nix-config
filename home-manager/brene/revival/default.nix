{ pkgs, myModulesPath, ... }:
{
  imports = [
    # (myModulesPath + "/neovim")
  ];

  home.packages = with pkgs; [
    btop
    # docker-client # check if docker cli works
    gcc
    nix-diff
    nix-index
    # nodejs # Node is required for Copilot.vim
    # nodePackages.prettier
    ookla-speedtest
    # sops # pushing secrets via git
    whois

    # unstable.devenv # maybe later ???
  ];

#   programs.fish = {
#     shellAliases = {
#       tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
#     };
#   };
}