{
  nysa.Poseidon.enable = true;

  elysium = {
    desktops.desktops.niri.enable = true;

    development = {
      languages.python.enable = false;
    };

    programs = {
      art.enable = true;
      internet.enable = true;
      office.enable = true;
      utilities.enable = true;
    };
  };

  # Just don't change unless absolutly necessary
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
