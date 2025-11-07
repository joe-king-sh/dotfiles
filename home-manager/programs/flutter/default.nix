{ pkgs, ... }:
{
  home.packages = with pkgs; [
    flutter
    cocoapods
  ];

  home.sessionVariables = {
    ANDROID_HOME = "$HOME/Library/Android/sdk";
    ANDROID_SDK_ROOT = "$HOME/Library/Android/sdk";
  };

  home.sessionPath = [
    "$HOME/Library/Android/sdk/platform-tools"
    "$HOME/Library/Android/sdk/tools"
  ];
}
