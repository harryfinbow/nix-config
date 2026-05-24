topLevel: {
  flake.modules.nixos.helium = {
    imports = [ topLevel.inputs.helium-nix.nixosModules.helium ];
    nix.settings = {
      substituters = [ "https://helium-nix.cachix.org" ];
      trusted-public-keys = [ "helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw=" ];
    };
  };

  flake.modules.homeManager.helium = {
    imports = [ topLevel.inputs.helium-nix.homeManagerModules.helium ];
    programs.helium = {
      enable = true;
      # extensions = [
      #   {
      #     id = "nngceckbapebfimnlniiiahkandclblb";
      #     hash = "sha256-47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=";
      #   } # Bitwarden
      #   {
      #     id = "jplgfhpmjnbigmhklmmbgecoobifkmpa";
      #     hash = "sha256-47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=";
      #   } # Proton VPN
      # ];

      # https://chromeenterprise.google/policies/
      extraPolicies = {
        PasswordManagerEnabled = false;
        BrowserSignin = 0;
      };

      # helium://prefs-internals/
      preferences = {
        helium = {
          browser = {
            custom_chrome_frame = false; # System title bar
            layout = 2; # Vertical tabs
            mru_tab_cycling = true; # Cycle most recent tabs
          };
        };
      };
    };
  };
}
