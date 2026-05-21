{
  flake.modules.nixos.swaylock = {
    # https://wiki.nixos.org/wiki/Swaylock
    security.pam.services.swaylock = { };
  };

  flake.modules.homeManager.swaylock = {
    programs.swaylock = {
      enable = true;
    };
  };
}
