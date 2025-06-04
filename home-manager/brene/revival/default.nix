{ pkgs, myModulesPath, ... }:
{
  imports = [
    # (myModulesPath + "/neovim")
  ];

  home.packages = with pkgs; [
    btop
    # docker-client # check if docker cli works
    gcc
    unstable.keymapper
    nix-diff
    # nodejs # Node is required for Copilot.vim
    # nodePackages.prettier
    ookla-speedtest
    python3
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