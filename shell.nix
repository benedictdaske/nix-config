# Shell for bootstrapping flake-enabled nix and home-manager
# Enter it through 'nix develop' or (legacy) 'nix-shell'

{ pkgs ? import <nixpkgs> { } }:
{
  default = pkgs.mkShell {
    packages = with pkgs; [
    ];

    inputsFrom = with pkgs; [ ];

    name = "dev";

    shellHook = ''
      echo "Entered Dev Shell"
    '';
  };

  iotsec = pkgs.mkShell {
    packages = with pkgs; [
      gdb
      minicom
      qemu
    ];

    inputsFrom = with pkgs; [ ];

    name = "iotsec";

    shellHook = ''
      echo "Entered IoT Sec Shell"
    '';
  };

  test = pkgs.mkShell {
    packages = with pkgs; [
      cowsay
    ];

    inputsFrom = with pkgs; [ ];

    name = "test";

    shellHook = ''
      echo "Welcome to the test shell!"
    '';
  };
}
