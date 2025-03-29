{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./../../modules/home-manager/brave.nix
    ./../../modules/home-manager/git.nix
    ./../../modules/home-manager/nvim.nix
    ./../../modules/home-manager/kitty.nix
    ./../../modules/home-manager/packages.nix
    ./../../modules/home-manager/i3.nix
    ./../../modules/home-manager/tmux.nix
    ./../../modules/home-manager/nushell.nix
    ./../../modules/home-manager/nixos-rebuild-script.nix
    ./../../modules/home-manager/modules.nix
  ];
  # Custom Modules
  desktop-background = {
    enable = true;
  };

  home.username = "eda";
  home.homeDirectory = "/home/eda";

  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
