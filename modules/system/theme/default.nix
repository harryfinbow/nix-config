topLevel:
let
  stylixModule = { config, pkgs, ... }: {
    stylix = {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";

      fonts = {
        monospace = {
          package = pkgs.maple-mono.Normal-NF;
          name = "Maple Mono Normal NF";
        };

        sansSerif = {
          package = pkgs.inter;
          name = "Inter";
        };

        serif = config.stylix.fonts.sansSerif;

        sizes = {
          terminal = 14;
        };
      };

      image = ./wallpapers/snowy.png;
    };
  };

  catppuccinModule = {
    catppuccin = {
      enable = true;
      autoEnable = false;
      flavor = "frappe";
    };
  };
in
{
  flake.modules.nixos.default = { pkgs, ... }: {
    imports = [
      topLevel.inputs.catppuccin.nixosModules.catppuccin
      topLevel.inputs.stylix.nixosModules.stylix
      stylixModule
      catppuccinModule
    ];

    stylix.cursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 16;
    };
  };

  flake.modules.darwin.default = {
    imports = [
      topLevel.inputs.stylix.darwinModules.stylix
      stylixModule
    ];
  };

  flake.modules.homeManager.default = { pkgs, ... }: {
    imports = [
      topLevel.inputs.catppuccin.homeModules.catppuccin
      catppuccinModule
    ];

    home.packages = with pkgs; [ vivid ];

    catppuccin.nushell.enable = true;
    stylix.targets.nushell.enable = false;

    # https://github.com/nix-community/stylix/pull/2501
    stylix.targets.rofi.enable = false;
  };
}
