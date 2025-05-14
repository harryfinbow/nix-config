{

    microvm = {
      hypervisor = "firecracker";
      interfaces = [
        {
          type = "tap";
          id = "vm-router";
          mac = "02:00:00:00:00:01";
          # bridge = "router";
        }
      ];
    };

    # boot.kernel.sysctl = {
    #   "net.ipv4.conf.all.forwarding" = 1;
    # };

    # networking.networkmanager.enable = lib.mkForce false;
    #
    # systemd.network = {
    #   enable = true;
    #
    #   netdevs = {
    #     "10-router" = {
    #       netdevConfig = {
    #         Name = "router";
    #         Kind = "bridge";
    #       };
    #     };
    #   };
    #
    #   networks = {
    #     "20-wan" = {
    #       matchConfig.MACAddress = "02:00:00:00:00:01";
    #       networkConfig.Bridge = "router";
    #     };
    #
    #     "30-router" = {
    #       matchConfig.Name = "router";
    #       networkConfig = {
    #         Address = "10.0.0.2/24";
    #       };
    #     };

        # "10-wan" = {
        #   matchConfig.Type = "ether";
        #   networkConfig = {
        #     DHCP = "yes";
        #     # IPv4ForwardingEnabled = "yes";
        #   };
        # };

        # "10-wan" = {
        #   matchConfig.Type = "ether";
        #   networkConfig = {
        #     Address = ["192.168.1.10/24"];
        #     Gateway = "192.168.1.1";
        #     DNS = ["192.168.1.1"];
        #     IPv6AcceptRA = true;
        #     DHCP = "no";
        #   };
        # };

        # "20-lan" = {
        #   matchConfig.Name = "enp2s0"; # TODO: What should this be set to?
        #   networkConfig = {
        #     Address = "192.168.100.0/24";
        #     # IPv4ForwardingEnabled = "yes";
        #   };
        # };
      # };
#       };
#     };
}
