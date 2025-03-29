{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.rebuild;
in {
  options = {
    rebuild.enable = lib.mkEnableOption "adds rebuild script to path";
    rebuild.command = lib.mkOption {
      type = lib.types.str;
      default = "sudo nixos-rebuild switch --flake ~/nixos";
      description = "Command for rebuilding flake";
    };
  };

  config = let
    #Script taken from noboilerplate https://github.com/0atman/noboilerplate/blob/main/scripts/38-nixos.md
    rebuildScript = pkgs.writeShellScriptBin "rebuild" ''
      #!/bin/sh
      set -e #exit on an error
      pushd ~/nixos

      # Early return if no changes were detected (thanks @singiamtel!)
      echo -e "====================\n  Detecting Changes...\n===================="
      echo
      if git diff --quiet '*.nix'; then
          read -p "No changes detected, build anyways? [Y|n] " -n 1 -r
          echo
          if [[ ! $REPLY =~ ^[Yy]$ ]]
          then
              echo "No changes detected, exiting."
              popd
              exit 0
          fi
      fi
      git diff --minimal --ignore-blank-lines --color -U0 '*.nix' | cat
      git add .

      # Autoformat your nix files
      echo -e "Formating..."
      ${pkgs.alejandra}/bin/alejandra . &>/dev/null \
        || ( ${pkgs.alejandra}/bin/alejandra . ; echo "formatting failed!" && exit 1)


      echo -e "Rebuilding nixos..."
      ${cfg.command}
      current=$(nixos-rebuild list-generations | grep current | sed 's/\([0-9]\+\) *current *\([0-9-]\+ [0-9:]\+\).*/Generation \1 Built at \2/' -)

      echo -e "Commiting changes..."
      git commit -am "$current"
      ${pkgs.libnotify}/bin/notify-send -e "Home Manager Succesfully Rebuild"

      popd
    '';
  in
    lib.mkIf cfg.enable {
      home.packages = [
        rebuildScript
      ];
    };
}
