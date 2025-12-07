{ config, pkgs, ...}:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
    # set the new prefix
    unbind C-b
    set -g prefix C-a
    bind -n C-a send-prefix

    # split planes using | and -
    bind | split-window -h
    bind - split-window -v
    unbind '"'
    unbind %

    # switch panes using Alt-arrow without prefix
    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    # enable mouse control (clickable windows, panes, resizeable panes)
    set -g mouse on
    ''; 
  };
}
