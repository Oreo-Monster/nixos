# This nixos module sets up the xserver for i3+xfce
# modules/home-manager/i3.nix is a complementry module
# home manager module configures i3
{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
    services.xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
        wallpaper = {
          combineScreens = false;
          mode = "fill";
        };
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
          rofi
        ];
      };
    };

    services.displayManager.defaultSession = "xfce+i3";

    services.picom = {
      enable = true;
      settings = {
        corner-radius = 5;
      };
    };
  };
}
