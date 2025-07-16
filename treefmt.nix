{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    statix.enable = true;
    biome.enable = true;
    prettier.enable = true;
  };
  settings.global.excludes = [
    "*.lock"
    ".secrets.baseline"
  ];
}
