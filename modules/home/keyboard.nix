{
  config,
  lib,
  ...
}:

{
  home.keyboard = {
    options = [
      "caps:swapescape"
      "compose:ralt"
    ];
  };

  wayland.windowManager.hyprland.settings.input.kb_options =
    lib.mkDefault <| lib.concatStringsSep "," config.home.keyboard.options;
}
