{
  chaos,
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/${chaos.username}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.secrets}/secrets.yaml";

    secrets = {
      "ssh_keys/Poseidon/${chaos.hostName}" = {
        path = "/home/${chaos.username}/.ssh/id_ed25519";
      };

      "ssh_keys/Poseidon/git" = {
        path = "/home/${chaos.username}/.ssh/git_ed25519";
      };
    };
  };
}
