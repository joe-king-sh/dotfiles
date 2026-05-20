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
      fzf # Fuzzy finder
      neofetch # System information display
      awscli2 # AWS CLI
      awsume # AWS assume role helper
      ssm-session-manager-plugin
      google-cloud-sdk # Google Cloud CLI
      gh
      mas # Mac App Store command line interface
      pre-commit # Pre-commit hooks
      python3Packages.detect-secrets # Secrets detection
      _1password-cli # 1Password CLI
      postgresql # PostgreSQL client (psql)
      zed-editor # Modern code editor
      terminal-notifier # macOS notifications from terminal
      gcalcli # Google Calendar CLI
      terraform # Infrastructure as Code
      wrangler # Cloudflare CLI
      viddy # Modern watch command
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
    ./programs/tailscale
    ./programs/tmux
    ./programs/aws
  ];

  programs.home-manager.enable = true;
}
