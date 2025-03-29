{
  config,
  lib,
  ...
}: let
  cfg = config.git;
in {
  options = {
    git.enable = lib.mkEnableOption "Enable git with user name and email";
  };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Eda Wright";
      userEmail = "ewrong16@gmail.com";
    };
  };
}
