{
  config,
  pkgs,
  inputs,
  ...
}: {
  config = {
    programs.kitty = {
      enable = true;
      font.name = "Hasklug Nerd Font";
      themeFile = "Nord";
    };
  };
}
