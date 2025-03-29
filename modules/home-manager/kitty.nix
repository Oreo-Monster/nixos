{
  config,
  lib,
  ...
}: let
  cfg = config.kitty;
in {
  options = {
    kitty.enable = lib.mkEnableOption "Enable Kitty";
  };
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font.name = "Hasklug Nerd Font";
      themeFile = "Nord";
    };
  };
}
