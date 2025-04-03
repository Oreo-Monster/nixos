{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.tmux;
in {
  options = {
    tmux.enable = lib.mkEnableOption "enables tmux";
  };
  config =
    lib.mkIf cfg.enable {
      programs.tmux = {
        enable = true;
        keyMode = "vi";
        sensibleOnTop = true;
        shell = "${pkgs.nushell}/bin/nu";
        plugins = with pkgs.tmuxPlugins; [
          yank
          nord
        ];
        extraConfig = "
is_vim=\"ps -o tty= -o state= -o comm= | \\
rg -i -E '^#{s|/dev/||:pane_tty} +[^TXZ ]+ +(\\\\S+\\\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'\"
bind-key -n 'C-h' if-shell \"$is_vim\" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell \"$is_vim\" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell \"$is_vim\" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell \"$is_vim\" 'send-keys C-l'  'select-pane -R'
tmux_version='$(tmux -V | sed -En \"s/^tmux ([0-9]+(.[0-9]+)?).*/\\1/p\")'
if-shell -b '[ \"$(echo \"$tmux_version >= 3.0\" | bc)\" = 1 ]' \\
    \"bind-key -n 'C-\\\\' if-shell \\\"$is_vim\\\" 'send-keys C-\\\\\\\\'  'select-pane -l'\"

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R

unbind-key C-b
set-option -g prefix C-Space
bind-key C-Space send-prefix
#set -g mouse on
      ";
      };
    };
}
