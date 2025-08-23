{
  chaos,
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.browsers;
  cfg = cfg'.browsers.zen;
in
{
  imports = [
    inputs.zen-browser.homeModules.default
  ];
  options.elysium.browsers.browsers.zen.enable = lib.mkEnableOption "Zen Browser";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.zen-browser = {
      enable = true;

      profiles.${chaos.username} = {
        id = 0;
        extensions = {
          packages = map (name: pkgs.firefoxExtensions.${name}) [
            "canvasblocker"
            "proton-pass"
            "startpage-private-search"
            "ublock-origin"
            "unpaywall"
          ];

          force = true;
        };

        search = {
          default = "startpage";
          privateDefault = "startpage";

          order = [
            "startpage"
            "ddg"
          ];
          engines = {
            startpage = {
              name = "Startpage - English";
              icon = "https://www.startpage.com/favicon.ico";
              urls = [
                {
                  template = "https://www.startpage.com/do/dsearch";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                    {
                      name = "language";
                      value = "english";
                    }
                    {
                      name = "cat";
                      value = "web";
                    }
                  ];
                }
              ];

              metaData.alias = "@s";
            };

            google.metaData.hidden = true;
            bing.metaData.hidden = true;
            amazondotcom-us.metaData.hidden = true;
            ebay.metaData.hidden = true;
            wikipedia.metaData.hidden = true;
          };

          force = true;
        };
      };
    };
  };
}
