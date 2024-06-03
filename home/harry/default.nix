{ config, inputs, lib, pkgs, ... }:

{
  imports = [ inputs.agenix.homeManagerModules.default ../common/wayland ];

  age = {
    identityPaths = [ "/home/harry/.ssh/id_ed25519" ];
    secrets.wallpaper.file = ../../secrets/wallpaper.age;
  };

  home.pointerCursor = {
    package = lib.mkForce pkgs.gnome.adwaita-icon-theme;
    gtk.enable = true;
  };

  gtk.enable = true;

  home.username = "harry";
  home.homeDirectory = "/home/harry";

  home.packages = with pkgs; [
    # Desktop
    spotify
    discord

    # System
    neofetch
    btop
    alsa-utils

    # Utilities
    jq
    eza

    # Games
    inputs.nix-citizen.packages.${pkgs.system}.star-citizen
    inputs.nix-citizen.packages.${pkgs.system}.lug-helper
    lutris
    gamescope
    mangohud
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      shell = { program = "${pkgs.fish}/bin/fish"; };
      font.size = lib.mkForce 16;
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      vim = "nvim";
      vi = "nvim";
    };

    shellAbbrs = {
      ls = "eza";
      ll = "eza -la";
      cdr = "cd (git rev-parse --show-toplevel)";

      k = "kubectl";
      ka = "kubectl apply";
      kd = "kubectl describe";
      kg = "kubectl get";

      gl = "git log --oneline -n 15";
      gs = "git status";
      gsw = "git switch";
      gr = "git rebase";
      gro = "git rebase origin/main";
      gru = "git remote update";
    };

    plugins = [{
      name = "pure";
      src = pkgs.fishPlugins.pure.src;
    }];
  };

  programs.git = {
    enable = true;
    userName = "Harry Finbow";
    userEmail = "harry@finbow.dev";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${config.age.secrets.wallpaper.path}" ];
      wallpaper = [ ",${config.age.secrets.wallpaper.path}" ];
    };
  };

  # Restart systemd
  systemd.user.startServices = "sd-switch";

  # Let `home-manager` manage itself
  programs.home-manager.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
