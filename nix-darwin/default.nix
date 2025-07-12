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
      "claude"

      # Terminal
      "warp"

      # Browser
      "google-chrome"
      "arc"

      # Collaboration
      "slack"
      "zoom"
      "notion"
      "gather"

      # Utility
      "1password"
      "karabiner-elements"
      "raycast"
    ];
  };

  # macOS system settings
  system.defaults = {

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 18;
      "com.apple.trackpad.scaling" = 3.0;
      _HIHideMenuBar = false;
    };

    universalaccess = {
      mouseDriverCursorSize = 4.0;
    };

    controlcenter = {
      BatteryShowPercentage = true;
    };

    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "clmv";
    };

    trackpad = {
      TrackpadThreeFingerDrag = true;
    };


    dock = {
      autohide = true;
      show-recents = false;
      orientation = "left";
      autohide-delay = 0.0;
      autohide-time-modifier = 0.5;
      expose-group-apps = true;
      expose-animation-duration = 0.1;

      magnification = true;
      largesize = 80;
      tilesize = 48;
    };

    screencapture = {
      location = "~/Desktop/screenshot";
      type = "png";
    };
  };
}
