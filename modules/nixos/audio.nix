{ inputs, lib, ... }:

{
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];

  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };
}
