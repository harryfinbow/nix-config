{
  lib,
  config,
  currentSystemUser,
  ...
}:

{
  options.modules.virtualisation = {
    enable = lib.mkEnableOption "enables virtualisation";
  };

  config = lib.mkIf config.modules.virtualisation.enable {

    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };
  };
}
