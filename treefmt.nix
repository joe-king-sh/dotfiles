{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    statix.enable = true;
  };
  settings.global.excludes = [ ];
}
