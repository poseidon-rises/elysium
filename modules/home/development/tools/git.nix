{ config, lib, ... }:

let
  cfg = config.elysium.development.tools.git;
in
{
  options.elysium.development.tools.git.enable = lib.mkEnableOption "Git" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        aliases = {
          co = "checkout";
          undo = "reset --hard HEAD~1";
        };

        user.name = "Poseidon";
        user.email = "softwaredevelopment.stingray177@passinbox.com";
      };

      signing = {
        format = "ssh";
        key = "~/.ssh/git_ed25519";
        signByDefault = true;
      };
    };
  };
}
