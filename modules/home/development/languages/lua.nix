{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.development;
in
{
  options.elysium.development.languages.lua.enable = lib.mkEnableOption "Lua Dev" // {
    default = cfg'.enable;
  };
}
