{ inputs, outputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      inputs.nvf.homeManagerModules.default
      outputs.homeModules.elysium
    ];

    backupFileExtension = "backup";
  };
}
