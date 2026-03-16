{
  flake.modules.nixos.default = {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };
  };

  flake.modules.homeManager.default =
    { pkgs, ... }:
    {
      services.podman = {
        enable = true;
      }
      // (if pkgs.stdenv.isDarwin then { useDefaultMachine = true; } else { });
    };
}
