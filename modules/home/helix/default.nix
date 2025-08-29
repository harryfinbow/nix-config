{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.modules.helix = {
    enable = lib.mkEnableOption "enables helix";
  };

  config = lib.mkIf config.modules.helix.enable {
    programs.helix = {
      enable = true;
      extraPackages = with pkgs; [
        # Go
        gopls
        gotools

        # Markdown
        marksman

        # Nix
        nil
        nixfmt-rfc-style

        # Python
        ruff
        python3Packages.jedi-language-server
        python3Packages.python-lsp-server

        # Yaml
        yaml-language-server
      ];
      settings = {
        editor = {
          line-number = "relative";
          true-color = true; # Required for most themes (including `stylix`)
          bufferline = "always";
        };
        editor.file-picker = {
          hidden = false;
        };
      };
      languages = {
        language = [
          {
            name = "go";
            auto-format = true;
            formatter = {
              command = lib.getExe' pkgs.gotools "goimports";
            };
          }
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = lib.getExe pkgs.nixfmt-rfc-style;
            };
          }
          {
            name = "yaml";
            file-types = [
              "yml"
              "yaml"
              "bst"
              "conf"
            ]; # Add Buildstream support
          }
        ];
      };
    };
  };
}
