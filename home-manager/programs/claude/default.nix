{ pkgs, lib, ... }:

{
  # Overlay to downgrade Claude Code to version 1.0.24
  nixpkgs.overlays = [
    (self: super: {
      claude-code = super.claude-code.overrideAttrs (oldAttrs: rec {
        version = "1.0.24";
        src = pkgs.fetchurl {
          url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
          sha256 = "1ci3l4l3xjr9xalmldi42d6zkwjc5p1nw04ccxlvnczj1syfnwsm";
        };
      });
    })
  ];

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
