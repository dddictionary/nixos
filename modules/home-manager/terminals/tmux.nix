{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-a";
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'moon'
          set -g @rose_pine_host 'off'
          set -g @rose_pine_user 'off'
          set -g @rose_pine_date_time '%Y-%m-%d %H:%M:%S'
          set -g @rose_pine_show_current_program 'on'
          set -g @rose_pine_show_pane_directory 'off'
        '';
      }
    ];

    extraConfig = ''
      # Reload config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind "'"
      unbind %

      # Switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Extended keys (Shift+Enter, Ctrl+Enter support)
      set -g extended-keys on
      set -g extended-keys-format csi-u
      set -as terminal-features 'xterm*:extkeys'

      # Vi copy mode bindings
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-alternative
      bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle

      # Status bar
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-interval 1
    '';
  };
}
