{lib, ...}: {
  imports = [
    ./desktop-background.nix
    ./brave.nix
    ./git.nix
    ./nvim.nix
    ./kitty.nix
    ./packages.nix
    ./i3.nix
    ./tmux.nix
    ./nushell.nix
    ./nixos-rebuild-script.nix
    ./nvf.nix
  ];

  brave.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  nvf.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;
  tmux.enable = lib.mkDefault true;
  nushell.enable = lib.mkDefault true;
  rebuild.enable = lib.mkDefault true;
}
