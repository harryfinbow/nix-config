{ inputs, pkgs, ... }:

{
  imports = [ inputs.nix-citizen.nixosModules.StarCitizen ];


  # Star Citizen
  nix-citizen.starCitizen = {
    enable = true;
    preCommands = ''
      export DXVK_HUD=compiler;
      export MANGO_HUD=1;
      export dual_color_blend_by_location="true";
    '';
    helperScript = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.nix-citizen.packages.${pkgs.system}.lug-helper
    lutris
    mangohud
    inputs.nix-citizen.packages.${pkgs.system}.umu
  ];

  nix.settings = {
    substituters = [
      "https://nix-gaming.cachix.org"
      "https://nix-citizen.cachix.org"
    ];

    trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
    ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 24 * 1024;
  }];
}
