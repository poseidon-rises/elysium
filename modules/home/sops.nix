{
  hostSpec,
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/${hostSpec.username}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.secrets}/secrets.yaml";

    secrets = {
      "ssh_keys/Poseidon/${hostSpec.hostName}" = {
        path = "/home/${hostSpec.username}/.ssh/id_ed25519";
      };

      "ssh_keys/Poseidon/git" = {
        path = "/home/${hostSpec.username}/.ssh/git_ed25519";
      };
    };
  };
}
