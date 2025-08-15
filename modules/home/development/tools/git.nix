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
      aliases = {
        co = "checkout";
        undo = "reset --hard HEAD~1";
      };

      userName = "Poseidon";
      userEmail = "softwaredevelopment.stingray177@passinbox.com";
    };
  };
}
