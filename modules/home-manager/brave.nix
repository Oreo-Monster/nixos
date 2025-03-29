{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.brave;
in {
  options = {
    brave.enable = lib.mkEnableOption "enable brave";
  };

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
      ];
    };
  };
}
