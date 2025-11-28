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
      grep = "rg";

      # Git related
      g = "git";
      gs = "git status";
      ga = "git add";
      gaa = "git add -A";
      gcm = "git commit";
      gps = "git push";
      gpl = "git pull";
      gl = "git log --oneline";
      gd = "git diff";
      gb = "git branch";
      gc = "git checkout";

      # Package managers
      pf = "pnpm --filter";

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
      ms = "make switch";
      msh = "make switch-home";

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

      # Git branch function for prompt
      git_branch() {
        local branch
        branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        if [ -n "$branch" ]; then
          # Check if there are uncommitted changes
          if git diff-index --quiet HEAD -- 2>/dev/null; then
            echo " %F{green}($branch)%f"  # Clean
          else
            echo " %F{red}($branch)%f"    # Dirty
          fi
        fi
      }

      # Custom prompt with git branch
      setopt PROMPT_SUBST
      PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$(git_branch)$ '

      # fzf settings
      export FZF_DEFAULT_COMMAND='fd --type f'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND='fd --type d'
      export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

      # bat settings
      export BAT_THEME="Dracula"

      # Load local zsh configuration if it exists
      # Note: zshrc.local should be in the dotfiles directory
      local_zshrc="$HOME/dotfiles/home-manager/programs/zsh/zshrc.local"
      if [ -f "$local_zshrc" ]; then
        source "$local_zshrc"
      fi

      # Disable npm
      alias npx='echo "WARNING: npx は実行しないでください" && false'
      alias npm='echo "WARNING: npm は実行しないでください" && false'

      # 1password cli
      source /Users/kinjo.shuya/.config/op/plugins.sh
    '';
  };
}
