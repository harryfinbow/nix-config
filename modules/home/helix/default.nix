{ config, lib, ... }:

{
  options.modules.helix = {
    enable = lib.mkEnableOption "enables helix";
  };

  config = lib.mkIf config.modules.helix.enable {
    programs.helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
          true-color = true; # Required for most themes (including `stylix`)
        };
      };
      languages = {
        language = [{
          name = "yaml";
          file-types = [ "yml" "yaml" "bst" "conf" ]; # Add Buildstream support
        }];
      };
    };
  };
}
