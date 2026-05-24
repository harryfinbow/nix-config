{
  flake.modules.nixos.default = {
    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    security.sudo.extraConfig = ''
      Defaults timestamp_timeout=60
    '';
  };
}
