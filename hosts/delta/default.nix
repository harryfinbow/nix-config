{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Configure modules
  modules = {
    audio.enable = false;
    hyprland.enable = false;
    minecraft-server.enable = true;
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

    netdevs = {
      "br0" = {
        netdevConfig = {
          Name = "br0";
          Kind = "bridge";
        };
      };
    };

    networks = {
      "10-lan" = {
        matchConfig.Name = ["enp1s0" "vm-*"];
        networkConfig.Bridge = "br0";
      };

      "10-lan-bridge" = {
        matchConfig.Name = "br0";
        networkConfig = {
          Address = "10.0.0.2/24";
          Gateway = "10.0.0.1";
        };
        linkConfig.RequiredForOnline = "routable";
      };
    };  
  };
}
