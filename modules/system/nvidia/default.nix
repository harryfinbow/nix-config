{
  flake.modules.nixos.nvidia =
    { config, ... }:
    {
      hardware = {
        nvidia = {
          open = true;
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
