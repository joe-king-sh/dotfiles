_: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Commonly used aliases
    shellAliases = {
      # Basic commands (using modern alternative tools)
      ll = "eza -la";
      la = "eza -la";
      l = "eza -l";
      ls = "eza";
      cat = "bat";
      find = "fd";
      grep = "ripgrep";

      # Git related
      g = "git";
      gs = "git status";
      ga = "git add";
      gaa = "git add -A";
      gcm = "git commit";
      gps = "git push";
      gl = "git log --oneline";
      gd = "git diff";
      gb = "git branch";
      gc = "git checkout";

      # Directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Useful commands
      tree = "tree -C";
      h = "history";
      cl = "clear";
      top = "htop";
      cc = "claude";

      # System related
      reload = "source ~/.zshrc";

      # Nix related
      # ns = "sudo nix run github:LnL7/nix-darwin --extra-experimental-features 'flakes nix-command' -- switch --flake "".#joe-king-sh""";
      # nsh = "nix run github:nix-community/home-manager --extra-experimental-features 'flakes nix-command' -- switch --flake "".#joe-king-sh""";

      # fzf related
      fzf-preview = "fzf --preview 'bat --color=always {}'";
    };

    # Environment variables
    sessionVariables = {
      EDITOR = "vim";
      BROWSER = "open";
    };

    # Initialization script
    initContent = ''
      # Prompt settings
      autoload -U colors && colors

      # History settings
      HISTSIZE=10000
      SAVEHIST=10000
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_FIND_NO_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt SHARE_HISTORY

      # Completion settings
      setopt AUTO_LIST
      setopt AUTO_MENU
      setopt LIST_PACKED

      # Directory navigation settings
      setopt AUTO_CD
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS

      # Other useful settings
      setopt CORRECT
      setopt CORRECT_ALL
      setopt NO_BEEP

      # Custom prompt
      PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '

      # fzf settings
      export FZF_DEFAULT_COMMAND='fd --type f'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND='fd --type d'

      # bat settings
      export BAT_THEME="Dracula"

      # Awsume
      ## AWSume alias to source the AWSume script
      alias awsume="source awsume"

      ## Auto-Complete function for AWSume (Zsh version)
      _awsume() {
          local -a opts
          opts=($(awsume-autocomplete))
          _describe 'awsume' opts
      }
      compdef _awsume awsume
    '';
  };
}
