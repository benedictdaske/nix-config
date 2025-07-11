# This file defines overlays
{ inputs, ... }:
{
    # When applied, the unstable nixpkgs set (declared in the flake inputs) will be accessible through 'pkgs.unstable'
    unstable-packages = final: _prev: rec {
        unstable = import inputs.nixpkgs-unstable {
            inherit (final) system;
            config.allowUnfree = true;
        };
    };
}