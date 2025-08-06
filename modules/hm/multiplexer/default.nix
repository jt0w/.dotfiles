{
  pkgs,
  inputs,
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
      {plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;}
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
    in ''
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
    '';
  };
}
