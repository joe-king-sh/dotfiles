{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    statix.enable = true;
    biome.enable = true;
  };
  settings.global.excludes = [ ];
}
