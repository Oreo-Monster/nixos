{
  config,
  pkgs,
  inputs,
  ...
}: {
  config = {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      nerd-fonts.hasklug
      nerd-fonts.hack
    ];
  };
}
