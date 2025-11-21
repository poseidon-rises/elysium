{
  config,
  lib,
  ...
}:
let
  cfg' = config.nysa.Poseidon.development.tools;
  cfg = cfg'.jujutsu;
in
{
  options.nysa.Poseidon.development.tools.jujutsu.enable = lib.mkEnableOption "Jujutsu VCS" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    programs.jujutsu.settings = {
      user.name = "Poseidon";
      user.email = "softwaredevelopment.stingray177@passinbox.com";

      signing = {
        behaviour = "own";
        backend = "ssh";

        backends.ssh.allowed-signers = "~/.ssh/allowed_signers";

        key = "~/.ssh/git_ed25519";
      };
    };
  };
}
