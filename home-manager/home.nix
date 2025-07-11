{
  username,
  homeDirectory,
  lib,
  pkgs,
  ...
}:
{
  home = {
    inherit username;
    homeDirectory = lib.mkForce homeDirectory;
    stateVersion = "24.11";
    
    # Useful command-line tools
    packages = with pkgs; [
      jq           # JSON processor
      tree         # Directory tree display
      htop         # System monitor
      bat          # cat alternative with syntax highlighting
      fd           # find alternative
      ripgrep      # grep alternative
      fzf          # Fuzzy finder
      eza          # ls alternative
      neofetch     # System information display
    ];
  };

  imports = [
    ./programs/nix
    ./programs/karabiner
    ./programs/git
    ./programs/zsh
  ];

  programs.home-manager.enable = true;
}
