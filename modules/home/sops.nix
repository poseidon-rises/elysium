{
  inputs,
  ...
}:

{
  sops.defaultSopsFile = "${inputs.secrets}/secrets.yaml";
}
