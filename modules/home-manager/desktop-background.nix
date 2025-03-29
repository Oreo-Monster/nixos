{
  config,
  lib,
  ...
}: let
  cfg = config.desktop-background;
in {
  options = {
    desktop-background.enable = lib.mkEnableOption "enables setting desktop background for i3";
    desktop-background.source = lib.mkOption {
      type = lib.types.str;
      default = "/../../wallpapers/cubes.jpg";
      description = "Source image";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file.".background-image" = {
      source = ./. + cfg.source;
    };
  };
}
