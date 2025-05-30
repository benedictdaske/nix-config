{ pkgs, ... }:
{
  users.users.brene = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/brene";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$XnmBzsaJKS7xReUH$DaTElmglmG.aVvcasOkGcIAszQaKegDaBQkuoe77.lTLkfWh/WJ5U43qAPO3swOz.e7ez1nQXJBW234WkjkRX0";
  };
}