_: {
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;

    extraConfig = ''
      # Pane index starts at 1
      setw -g pane-base-index 1

      # Renumber windows on close
      set -g renumber-windows on

      # Split panes with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Pane navigation with arrow keys
      bind Left select-pane -L
      bind Down select-pane -D
      bind Up select-pane -U
      bind Right select-pane -R

      # Resize panes with arrow keys
      bind -r S-Left resize-pane -L 5
      bind -r S-Down resize-pane -D 5
      bind -r S-Up resize-pane -U 5
      bind -r S-Right resize-pane -R 5

      # New window in current path
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
