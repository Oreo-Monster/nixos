{
  config,
  pkgs,
  inputs,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      #CLI Tools
      tree
      gitui
      cargo
      rustc

      obsidian
      discord
    ];
  };
}
