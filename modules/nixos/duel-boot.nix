{
  config,
  pkgs,
  inputs,
  ...
}: {
  config = {
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
    };
  };
}
