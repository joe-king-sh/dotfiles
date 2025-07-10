{
  username,
  homeDirectory,
  lib,
  ...
}:
{
  home = {
    inherit username;
    homeDirectory = lib.mkForce homeDirectory;
    stateVersion = "24.11";
  };

  imports = [
    ./programs/nix
    ./programs/karabiner
    ./programs/git
  ];

  programs.home-manager.enable = true;
}
