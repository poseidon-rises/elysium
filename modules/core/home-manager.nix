{ inputs, outputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      outputs.homeManagerModules.elysium
    ];

    backupFileExtension = ".backup";
  };
}
