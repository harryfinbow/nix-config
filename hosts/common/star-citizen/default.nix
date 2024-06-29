{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.nix-citizen.packages.${system}.star-citizen
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
}
