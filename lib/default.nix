{ self, inputs, outputs, user, stateVersion, ... }:
{
  loadSystems = import ./loadSystems.nix { inherit self inputs outputs user stateVersion; };
  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "x86_64-linux"
    "aarch64-darwin"
  ];
}
