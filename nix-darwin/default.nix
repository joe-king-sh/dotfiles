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
    NSGlobalDomain.KeyRepeat = 1;
    NSGlobalDomain.InitialKeyRepeat = 10;
    NSGlobalDomain._HIHideMenuBar = true;
    NSGlobalDomain."com.apple.trackpad.scaling" = 3.0;
    
    universalaccess.mouseDriverCursorSize = 3.0;
    controlcenter.BatteryShowPercentage = true;

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "clmv";
    };

    dock = {
      autohide = true;
      show-recents = false;
      orientation = "left";
      autohide-delay = 0.0;
      autohide-time-modifier = 0.5;
    };

    screencapture = {
      location = "~/Desktop/screenshot";
      type = "png";
    };
  };
}
