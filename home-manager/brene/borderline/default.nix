{ pkgs, myModulesPath, ... }:
{
  imports = [
    # (myModulesPath + "/rectangle")
  ];

  home.packages = with pkgs; [
    aldente # battery management
    docker-client # check if docker cli works

    # unstable.devenv # maybe later ???
  ];

#   programs.fish = {
#     shellAliases = {
#       tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
#     };
#   };
}