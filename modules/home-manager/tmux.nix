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

unbind-key C-b
set-option -g prefix C-Space
bind-key C-Space send-prefix
#set -g mouse on

# Start windows and panes at 1, not 0
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

set -g status-position top

# keybindings
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
unbind-key f
bind-key f resize-pane -Z

# Smart pane switching with awareness of Vim splits.
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim=\"ps -o state= -o comm= -t '#{pane_tty}' \\
    | grep -iqE '^[^TXZ ]+ +(\\\\S+\\\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'\"
bind-key -n 'C-h' if-shell \"$is_vim\" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell \"$is_vim\" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell \"$is_vim\" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell \"$is_vim\" 'send-keys C-l'  'select-pane -R'
tmux_version='$(tmux -V | sed -En \"s/^tmux ([0-9]+(.[0-9]+)?).*/\\1/p\")'
if-shell -b '[ \"$(echo \"$tmux_version < 3.0\" | bc)\" = 1 ]' \\
    \"bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'\"
if-shell -b '[ \"$(echo \"$tmux_version >= 3.0\" | bc)\" = 1 ]' \\
    \"bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\\\\\'  'select-pane -l'\"

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'C-\\' select-pane -l


      ";
      };
    };
}
