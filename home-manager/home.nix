{
  username,
  homeDirectory,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    inherit username;
    homeDirectory = lib.mkForce homeDirectory;
    stateVersion = "24.11";

    # Useful command-line tools
    packages = with pkgs; [
      jq # JSON processor
      tree # Directory tree display
      htop # System monitor
      bat # cat alternative with syntax highlighting
      fd # find alternative
      ripgrep # grep alternative
      fzf # Fuzzy finder
      eza # ls alternative
      neofetch # System information display
      awscli2 # AWS CLI
      ssm-session-manager-plugin
      gh
      mas # Mac App Store command line interface
      pre-commit # Pre-commit hooks
      python3Packages.detect-secrets # Secrets detection
      _1password-cli # 1Password CLI
    ];
  };

  imports = [
    ./programs/nix
    ./programs/karabiner
    ./programs/git
    ./programs/zsh
    ./programs/vscode
    ./programs/mise
    ./programs/claude
    ./programs/vim
    ./programs/rancher
    ./programs/flutter
    ./programs/pnpm
  ];

  programs.home-manager.enable = true;
}
