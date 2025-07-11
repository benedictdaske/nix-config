{ name, inputs, outputs, stateVersion }:
let
  inherit (inputs.nixpkgs) lib;

  # path management
  myLibPath = ../lib;
  systemsPath = ../systems;
  myModulesPath = ../modules;
  homeManagerPath = ../home-manager;

  # read user library
  filterDirs = lib.filterAttrs (_n: v: v == "directory");
  userDirs =
    builtins.attrNames
      (filterDirs (builtins.readDir homeManagerPath));
  usersForSystem =
    name: lib.flatten
      (builtins.map
        (user:
        (builtins.map (_v: user)
          (builtins.filter (n: n == name)
            (builtins.attrNames (filterDirs (builtins.readDir (homeManagerPath + "/${user}")))))))
        userDirs);
  users = usersForSystem name;

  # config based on system type
  isDarwin = builtins.pathExists (systemsPath + "/${name}/darwin-configuration.nix");
  configFile = if isDarwin then "darwin-configuration.nix" else "configuration.nix";
  configKey = if isDarwin then "darwinConfigurations" else "nixosConfigurations";
  systemFn = if isDarwin then inputs.nix-darwin.lib.darwinSystem else inputs.nixpkgs.lib.nixosSystem;
  homeManagerFn = if isDarwin then inputs.home-manager.darwinModules.home-manager else inputs.home-manager.nixosModules.home-manager;
  baseSystemConfig = systemsPath + "/base/${(if isDarwin then "darwin-configuration.nix" else "nixos-configuration.nix")}";

  # read env var for darwin casks
  greedyCasks = builtins.getEnv "GREEDY_CASKS" == "1";

  # home manager module args
  args = {
    inherit inputs users myLibPath myModulesPath;
    currentSystemName = name;
  };

  # deep attribute merging function
  recursiveMergeAttrs = builtins.foldl' lib.recursiveUpdate { };
in
{
  ${configKey}.${name} = systemFn {
    modules = [
      baseSystemConfig
      systemsPath
      (systemsPath + "/${name}/${configFile}")
    ] ++ lib.optionals (builtins.pathExists "${systemsPath}/${name}/hardware.nix") [
      (systemsPath + "/${name}/hardware.nix")
    ] ++ [
      homeManagerFn
      {
        # use globally defined nixpkgs
        home-manager.useGlobalPkgs = true;
        # packages to /etc/profile
        home-manager.useUserPackages = true;
        # home manager module args
        home-manager.extraSpecialArgs = args;
        # load home manager default.nix for each user (and system)
        home-manager.users = recursiveMergeAttrs (builtins.map
          (user: {
            ${user} = inputs.nixpkgs.lib.mkMerge ([
              (import homeManagerPath)
              (import (homeManagerPath + "/${user}"))
            ] ++ lib.optionals (builtins.pathExists (homeManagerPath + "/${user}/${name}")) [
              (import (homeManagerPath + "/${user}/${name}"))
            ]);
          })
          users);
      }
    ] ++ builtins.map
      # load system type specific config for each user
      (user:
        if !isDarwin && (builtins.pathExists (homeManagerPath + "/${user}/nixos-configuration.nix")) then
          import (homeManagerPath + "/${user}/nixos-configuration.nix")
        else if isDarwin && (builtins.pathExists (homeManagerPath + "/${user}/darwin-configuration.nix")) then
          import (homeManagerPath + "/${user}/darwin-configuration.nix")
        else { }
      )
      users;

    # pass custom args to system
    specialArgs = {
      inherit inputs outputs stateVersion users myLibPath myModulesPath;
      currentSystemName = name;
      inherit greedyCasks;
    };
  };
}