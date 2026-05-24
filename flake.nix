{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Dendritic Pattern
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # Other
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    beansprout.url = "git+https://codeberg.org/harryfinbow/beansprout?ref=nix-flake";
    beansprout.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/NixOS/nixpkgs/pull/498572
    helium-nix.url = "github:penal-colony/helium-nix";

    microvm.url = "github:astro/microvm.nix";
    microvm.inputs.nixpkgs.follows = "nixpkgs";

    # https://github.com/nix-media-server/nixarr/issues/163
    nixarr.url = "github:rasmus-kirk/nixarr?rev=7cc521933dc6800ae81ecfc91fe36237476e4ffb";
    nixarr.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    transmission-protonvpn.url = "github:pborzenkov/transmission-protonvpn-nat-pmp";

    # https://github.com/NixOS/nixpkgs/pull/414845
    vs2nix.url = "github:dtomvan/vs2nix";

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
