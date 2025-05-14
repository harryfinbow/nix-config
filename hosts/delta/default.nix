{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Configure modules
  modules = {
    audio.enable = false;
    hyprland.enable = false;
    minecraft.enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  systemd.network.enable = true;
  systemd.network.wait-online.enable = false;

  # Allow inbound traffic for the DHCP server
  networking.firewall.allowedUDPPorts = [ 67 ];

  networking.nat = {
    enable = true;
    externalInterface = "enp1s0";
    internalInterfaces = [ "router" ];
  };

  systemd.network = {
    netdevs = {
      "10-router" = {
        netdevConfig = {
          Name = "router";
          Kind = "bridge";
        };
      };
    };

    networks = {
      "20-router" = {
        matchConfig.Name = "router";
        networkConfig = {
          Address = "10.0.0.1/24";
          DHCPServer = true;
          IPv6SendRA = true;
        };
      };

      "30-router" = {
        matchConfig.Name = "vm-*";
        networkConfig = {
          Bridge = "router";
        };
      };
    };
  };
}
