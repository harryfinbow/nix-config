{ lib, config, ... }:

{
  imports = [ ./fan-controller.nix ];

  options.modules.nvidia = {
    enable = lib.mkEnableOption "enables nvidia";
  };

  config = lib.mkIf config.modules.nvidia.enable {
    hardware = {
      nvidia = {
        # Modesetting is required.
        modesetting.enable = true;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
