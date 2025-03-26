{
  config,
  pkgs,
  inputs,
  ...
}: {
  config = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      extensions = [
        {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
      ];
    };
  };
}
