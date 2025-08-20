{ config, lib, pkgs, ... }:

let
  cfg'' = config.elysium.development.languages;
  cfg' = cfg''.dotnet;
  cfg = cfg'.csharp;
in {
  options.elysium.development.languages.dotnet.csharp.enable = lib.mkEnableOption "CSharp Dev" // {
    default = cfg''.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.csharprepl ];

    assertions = [
      {
        assertion = cfg'.enable;
        message = "Dotnet must be enabled to use csharp";
      }
    ];
  };
}
