{ currentSystem, currentSystemUser, ... }:

let
  homeDirPrefix = if builtins.hasSuffix "darwin" currentSystem then "Users" else "home";
in
{
  home = {
    username = "${currentSystemUser}";
    homeDirectory = "/${homeDirPrefix}/${currentSystemUser}";
  };
}
