{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Configure modules
  modules = {
    audio.enable = false;
    hyprland.enable = false;
    vm.minecraft-server.enable = true;
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
}
