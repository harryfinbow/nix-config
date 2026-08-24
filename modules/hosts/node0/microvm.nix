topLevel:
let
  pkgs = null; # https://github.com/microvm-nix/microvm.nix/pull/218
  extraModules = [ topLevel.config.flake.modules.nixos.microvm ];
in
{
  flake.modules.nixos.node0 = {
    # TODO: Make this configurable
    # microvm.vms = {
    #   vm0 = {
    #     inherit pkgs;
    #     config = topLevel.config.flake.modules.nixos.vm0;
    #     extraModules = extraModules ++ [
    #       {
    #         # TODO: Sort this out (maybe make a root user)
    #         users.users.root.openssh.authorizedKeys.keys = [
    #           "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBhcj36L0yDUxWBWUo9MoxgrwnJGlm4VJGCsbBR8Owoc harry@alpha"
    #           "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPIM0ukzIdJpYpD6kNRCYkhh0G/UXVhSFKS3otW4VN+ harryf@bravo"
    #           "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIbtwmjASEl5jw3btx0MVHf5MshDX9JT5EbwI9BXH3G harry@foxtrot"
    #         ];

    #         microvm = {
    #           vcpu = 4;
    #           hotplugMem = 8192; # Maximum Memory (8 GiB)
    #           hotpluggedMem = 4096; # Initial Memory (4 GiB)

    #           shares = [
    #             {
    #               source = "/persist/microvms/vintagestory";
    #               mountPoint = "/var/lib/vintagestory"; # TODO: Is there a way to access this from the service option?
    #               tag = "persist";
    #               proto = "virtiofs";
    #             }
    #           ];

    #           interfaces = [
    #             {
    #               id = "vm0";
    #               mac = "02:00:00:00:00:01";
    #               type = "macvtap";
    #               macvtap = {
    #                 mode = "private";
    #                 link = "enp1s0";
    #               };
    #             }
    #           ];
    #         };
    #       }
    #     ];
    #   };
    # };
  };
}
