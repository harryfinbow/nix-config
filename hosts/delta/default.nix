{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Configure modules
  modules = {
    actual.enable = true;
    audio.enable = false;
    caddy.enable = true;
    glance.enable = true;
    grafana.enable = true;
    hyprland.enable = false;
    intel.enable = true;
    linkding.enable = true;
    nixarr.enable = true;
    prometheus.enable = true;
    uptime-kuma.enable = true;
    vm.minecraft-server.enable = false;
    vintagestory.enable = false;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  # Networking
  systemd.network = {
    enable = true;

    networks = {
      # Assign static IP
      "10-enp1s0" = {
        matchConfig.Name = "enp1s0";
        networkConfig = {
          Address = "10.0.0.2/24";
          Gateway = "10.0.0.1";
        };
      };
    };
  };

  # Required for Vintage Story
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];
}
