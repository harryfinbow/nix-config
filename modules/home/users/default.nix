{ currentSystem, currentSystemUser, lib, ... }:

let
  homeDirPrefix = if lib.hasSuffix "darwin" currentSystem then "Users" else "home";
in
{
  home = {
    username = "${currentSystemUser}";
    homeDirectory = "/${homeDirPrefix}/${currentSystemUser}";
  };
}
