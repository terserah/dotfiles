{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";

    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      tokyo-night-tmux
    ];

    extraConfig = ''

      set -g default-terminal "tmux-256color"
      set -ga terminal-features ",xterm-256color:RGB"
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      set -s extended-keys on
      set -s extended-keys always
      set -as terminal-features ',xterm*:extkeys'
    
      set -g @tokyo-night-tmux_theme storm
    '';
  };
}
