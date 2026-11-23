{ lib, inputs, pkgs, ... }: {
  nix = {
    # home manager needs to know which nix binary to use 
    package = pkgs.nix;

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; })
      (lib.filterAttrs (_: v: v ? outputs) inputs);

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # Avoid unwanted garbage collection when using nix-direnv
      keep-outputs = true;
      keep-derivations = true;
      warn-dirty = false;
    };
  };
}
