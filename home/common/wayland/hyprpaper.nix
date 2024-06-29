{ config, inputs, ... }:

{
  imports = [ inputs.agenix.homeManagerModules.default ];
  age = {
    identityPaths = [ "/home/harry/.ssh/id_ed25519" ]; # This should probably be moved to `home/harry/default.nix`
    secrets.wallpaper.file = ../../../secrets/wallpaper.age;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${config.age.secrets.wallpaper.path}" ];
      wallpaper = [ ",${config.age.secrets.wallpaper.path}" ];
    };
  };
}
