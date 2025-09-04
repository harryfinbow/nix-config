{
  ...
}:

{
  nixpkgs.overlays = [
    (_final: prev: {
      # https://github.com/nix-community/home-manager/issues/322#issuecomment-1178614454
      openssh = prev.openssh.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ./openssh.patch ];
        doCheck = false;
      });
    })
  ];
}
