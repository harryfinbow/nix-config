{ inputs, pkgs, lib, config, ... }:

{
  options.modules.star-citizen = {
    enable = lib.mkEnableOption "enables star-citizen";
  };

  config = lib.mkIf config.modules.star-citizen.enable {
    environment.systemPackages = [ inputs.nix-gaming.packages.${pkgs.system}.star-citizen ];

    boot.kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
    };

    zramSwap.enable = true;

    # https://github.com/cachix/cachix/issues/323
    nix.settings = {
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
  };
}
