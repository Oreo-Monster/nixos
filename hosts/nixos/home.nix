{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./../../modules/home-manager/modules.nix
  ];
  # Custom Modules
  desktop-background = {
    enable = true;
  };
  packages.enable = true;
  i3.enable = true;

  home.username = "eda";
  home.homeDirectory = "/home/eda";

  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
