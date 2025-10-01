{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.services.mpd;
  cfg = cfg'.discord-rpc;
in
{
  options.elysium.services.mpd.discord-rpc.enable = lib.mkEnableOption "MPD music" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    services.mpd-discord-rpc.enable = true;
  };
}
