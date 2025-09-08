{ pkgs, ... }:
{
  imports = [
    # (myModulesPath + "/neovim")
  ];

  home.packages = with pkgs; [
    sshs
  ];
}
