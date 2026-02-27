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
    brews = [
      "tailscale"
    ];
    casks = [
      # Dev-tools
      "cursor"
      "visual-studio-code"
      "android-studio"
      "claude"
      "claude-code"
      "rancher"
      "kiro"
      "kiro-cli"
      "postman"

      # Terminal
      "warp"
      "ghostty"

      # Browser
      "google-chrome"
      "arc"

      # Collaboration
      "slack"
      "zoom"
      "notion"
      "gather"
      "microsoft-teams"

      # Utility
      "1password"
      "karabiner-elements"
      "obsidian"
      "raycast"
      "tailscale"

      # office
      "microsoft-powerpoint"
      "microsoft-excel"
      "microsoft-word"
      "onedrive"
    ];

    # App Store
    masApps = {
      "RunCat" = 1429033973;
      "Skitch" = 425955336;
    };
  };

  # Launch agents (startup applications)
  launchd.user.agents = {
    # Auto-start 1Password
    "1password" = {
      serviceConfig = {
        ProgramArguments = [ "/Applications/1Password.app/Contents/MacOS/1Password" ];
        RunAtLoad = true;
      };
    };

    # Auto-start Karabiner-Elements
    "karabiner-elements" = {
      serviceConfig = {
        ProgramArguments = [ "/Applications/Karabiner-Elements.app/Contents/MacOS/Karabiner-Elements" ];
        RunAtLoad = true;
      };
    };

    # Auto-start Raycast
    "raycast" = {
      serviceConfig = {
        ProgramArguments = [ "/Applications/Raycast.app/Contents/MacOS/Raycast" ];
        RunAtLoad = true;
      };
    };

    # Auto-start Rancher Desktop
    "rancher-desktop" = {
      serviceConfig = {
        ProgramArguments = [ "/Applications/Rancher Desktop.app/Contents/MacOS/Rancher Desktop" ];
        RunAtLoad = true;
      };
    };
  };

  # macOS system settings
  system.defaults = {

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 18;
      "com.apple.trackpad.scaling" = 3.0;
      _HIHideMenuBar = false;
      AppleInterfaceStyle = "Dark";
    };

    universalaccess = {
      mouseDriverCursorSize = 4.0;
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Sound = true;
      Bluetooth = true;
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

    menuExtraClock = {
      ShowSeconds = true;
    };

    screencapture = {
      location = "~/Desktop/screenshot";
      type = "png";
    };

    CustomUserPreferences = {
      "com.apple.Sound" = {
        "Play sound on startup" = false;
      };
    };
  };
}
