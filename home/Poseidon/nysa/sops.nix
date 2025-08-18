{
  chaos,
  config,
  lib,
  ...
}:

let
  cfg' = config.nysa.Poseidon;
  cfg = cfg'.sops;
in
{
  options.nysa.Poseidon.sops.enable = lib.mkEnableOption "SOPS" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age.keyFile = "/home/${chaos.username}/.config/sops/age/keys.txt";

      secrets = {
        "${chaos.username}/ssh_keys/${chaos.hostName}" = {
          path = "/home/${chaos.username}/.ssh/id_ed25519";
        };

        "${chaos.username}/ssh_keys/git" = {
          path = "/home/${chaos.username}/.ssh/git_ed25519";
        };
      };
    };
  };
}
