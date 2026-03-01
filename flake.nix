{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    # Dendritic Pattern
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # Other
    agenix.url = "github:ryantm/agenix";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    nixarr.url = "github:rasmus-kirk/nixarr";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    transmission-protonvpn.url = "github:pborzenkov/transmission-protonvpn-nat-pmp";

    # https://github.com/NixOS/nixpkgs/pull/414845
    vs2nix.url = "github:dtomvan/vs2nix";

    # nix-darwin.url = "github:LnL7/nix-darwin";
    # nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # nixos-hardware.url = "github:harryfinbow/nixos-hardware/update-dell-latitude-7490";

    # # /nix/store/prgaw5y3kjcf91y1ld5g9diqnambgyib-wine-tkg-full-10.8.drv fails to build
    # nix-gaming.url = "github:fufexan/nix-gaming?ref=a094fde06697aba9c514b627850261810e771495";

    # nixos-generators.url = "github:nix-community/nixos-generators";
    # nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim.url = "github:nix-community/nixvim";

    # pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    # textfox.url = "github:adriankarlen/textfox";

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
