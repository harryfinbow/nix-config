{ inputs, lib, config, pkgs, ... }:

{
  options.modules.audio = {
    enable = lib.mkEnableOption "enables audio";
  };

  config = lib.mkIf config.modules.audio.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      alsa-utils
    ];
  };
}
