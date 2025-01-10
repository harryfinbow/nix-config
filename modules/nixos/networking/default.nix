{ currentSystemName, ... }:

{
  networking = {
    hostName = currentSystemName;
    networkmanager.enable = true;
  };
}
