{ config, lib, ... }:

let
  cfg = config.elysium.security.sudo-rs;
in
{
  options.elysium.security.sudo-rs.enable = lib.mkEnableOption "sudo-rs" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
		security.sudo-rs = { 
			enable = true;
			execWheelOnly = true;
		};
  };
}
