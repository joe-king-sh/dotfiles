{ pkgs, username, ... }:
{
  system.stateVersion = 5;
  system.primaryUser = username;

  security.sudo.extraConfig = ''
    ${username} ALL = (ALL) NOPASSWD: ALL
  '';
  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    casks = [
      # Dev-tools
      "cursor"
      "visual-studio-code"
      "android-studio"

      # Terminal
      "warp"

      # Browser
      "google-chrome"
      "arc"

      # Collaboration
      "slack"
      "zoom"
      "notion"

      # Utility
      "1password"
      "karabiner-elements"
      "raycast"
    ];
  };

  # macOS system settings
  system.defaults = {

    NSGlobalDomain.AppleShowAllExtensions = true;

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
    };

    dock = {
      autohide = true;
      show-recents = false;
      orientation = "left";
    };
  };
}
