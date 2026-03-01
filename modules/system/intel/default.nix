{
  flake.modules.nixos.intel =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        intel-gpu-tools
      ];

      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
      };

      # https://github.com/NixOS/nixpkgs/issues/356535#issuecomment-2614002200
      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver # VA-API (iHD) userspace
        ];
      };
    };
}
