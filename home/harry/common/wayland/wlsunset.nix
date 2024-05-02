{ pkgs, ... }: {
  services.wlsunset = {
    enable = true;
    latitude = "51.51";
    longitude = "0.13";
    temperature.night = 3500;
  };
}
