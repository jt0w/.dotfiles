{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    terminal = "screen-256color";
    escapeTime = 0;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmux-sessionx;
        extraConfig = "set -g @sessionx-bind 'f'";
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];
    extraConfig = let
      prefix = "ö";
    in with config.lib.stylix.colors.withHashtag; ''
      unbind C-b
      set-option -g prefix ${prefix}
      bind-key ${prefix} send-prefix

      set-option -g renumber-windows on
      set-option -g status-position top

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      # vim-like pane switching
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      set -g focus-events on
      set -g status-style fg=${base05},bg=default
      set-window-option -g window-status-style bg=default,fg=${base04}
      set-window-option -g window-status-current-style bg=default,fg=${base05}
      set -g status-left "#S"
      set -g status-right "%H:%M %d.%m.%y"
      set -g window-status-current-format "#I:#W"
      set -g window-status-format "#I:#W"

      set -g status-left-length 99
      set -g status-right-length 99
      set -g status-justify absolute-centre
    '';
  };
}
