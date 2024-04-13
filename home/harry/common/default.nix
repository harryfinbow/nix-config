{
  imports = [ ./terminal ];

  home = {
    username = "harry";
    homeDirectory = "/home/harry";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
