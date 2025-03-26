{
  config,
  pkgs,
  inputs,
  ...
}: {
  config = {
    programs.git = {
      enable = true;
      userName = "Eda Wright";
      userEmail = "ewrong16@gmail.com";
    };
  };
}
