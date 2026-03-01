topLevel: {
  flake.modules.nixos.microvm = {
    imports = [ topLevel.inputs.microvm.nixosModules.microvm ];

    microvm = {
      hypervisor = "cloud-hypervisor";
      optimize.enable = true;

      shares = [
        {
          source = "/nix/store";
          mountPoint = "/nix/.ro-store";
          tag = "ro-store";
          proto = "virtiofs";
        }
      ];
    };
  };
}
