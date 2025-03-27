# This nixos module configures i3
# modules/nixos/i3.nix installs and sets up i3
{
  config,
  pkgs,
  lib,
  ...
}: let
  modifier = "Mod1";
in {
  config = {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        focus = {
          mouseWarping = true;
          followMouse = true;
        };

        modifier = modifier;
        keybindings = {
          # App Controll
          "${modifier}+Shift+q" = "kill";
          "${modifier}+Shift+Return" = "exec rofi -show drun";
          # Focus Movement
          "${modifier}+k" = "focus up";
          "${modifier}+j" = "focus down";
          "${modifier}+h" = "focus left";
          "${modifier}+l" = "focus right";
          "${modifier}+0" = "workspace number 10";
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          # Container movement
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+l" = "move right";
          "${modifier}+Shift+0" = "move container to workspace number 10";
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+Shift-f" = "floating toggle";
          "${modifier}+Shift-r" = "layout stacking";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+t" = "layout tabbed";

          "${modifier}+Shift+r" = "restart";
          "${modifier}+a" = "focus parent";
          "${modifier}+x" = "split h";
          "${modifier}+v" = "split v";

          "${modifier}+r" = "mode resize";
        };
        gaps = {
          top = 5;
          bottom = 5;
          left = 5;
          right = 5;
          inner = 5;
        };
        fonts = {
          names = ["Hasklug Nerd Font"];
          style = "Bold";
          size = 14.0;
        };
      };
    };
  };
}
