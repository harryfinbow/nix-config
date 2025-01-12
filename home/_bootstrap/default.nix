{ config, lib, ... }:

{
  modules = lib.mapAttrs (_: _: { enable = false; }) config.modules;
}
