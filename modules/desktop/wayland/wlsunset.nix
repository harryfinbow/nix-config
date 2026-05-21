{
  flake.modules.homeManager.wlsunset = {
    services.wlsunset = {
      enable = true;
      latitude = "51.51";
      longitude = "0.13";
      temperature = {
        day = 6500;
        night = 3000;
      };
    };
  };
}
