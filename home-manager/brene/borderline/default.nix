{ pkgs, myModulesPath, ... }:
{
  imports = [
    # (myModulesPath + "/rectangle")
  ];

  home.packages = with pkgs; [
    btop
    # docker-client # check if docker cli works
    fzf
    gcc
    nix-diff
    # nodejs # Node is required for Copilot.vim
    # nodePackages.prettier
    ookla-speedtest
    python3
    ripgrep
    # sops # pushing secrets via git
    whois
    yazi
    zoxide

    # unstable.devenv # maybe later ???
  ];

#   programs.fish = {
#     shellAliases = {
#       tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
#     };
#   };
}