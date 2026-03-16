{
  flake.modules.darwin.default = {
    homebrew = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
