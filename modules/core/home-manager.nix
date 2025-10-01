{ inputs, outputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      outputs.homeModules.elysium
    ];

    backupFileExtension = "backup";
  };
}
