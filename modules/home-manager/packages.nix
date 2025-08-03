{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.packages;
in {
  options = {
    packages.enable = lib.mkEnableOption "Enables common packages";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      #CLI Tools
      tree
      gitui
      cargo
      rustc
      #Heaven
      claude-code

      #Desktop apps
      obsidian
      discord
      calibre
      steam
      inkscape
    ];
  };
}
