{ config, lib, pkgs, ... }:

{
  imports = [ ./disko.nix ];

  config.modules = lib.mapAttrs (_: _: { enable = false; }) config.modules;
}
