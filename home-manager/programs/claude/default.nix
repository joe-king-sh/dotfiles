{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
    ];

  home.packages = with pkgs; [
    claude-code
  ];

  # Also set in shell environment
  programs.zsh.sessionVariables = {
    CLAUDE_CONFIG_DIR = "$HOME/.config/claude";
  };
}
