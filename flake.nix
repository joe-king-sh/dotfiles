{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      treefmt-nix,
      ...
    }:
    let
      supportedSystems = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      system = "aarch64-darwin";
      username = "joe-king-sh";
      actualUsername = "kinjo.shuya";

      homeDirectory =
        if system == "aarch64-darwin" then
          "/Users/${actualUsername}"
        else
          throw "Unsupported system: ${system}";

      pkgs = pkgsFor system;

      specialArgs = {
        inherit system homeDirectory;
        username = actualUsername;
      };
    in
    {
      formatter = forAllSystems (
        sys:
        let
          sysPkgs = pkgsFor sys;
        in
        (treefmt-nix.lib.evalModule sysPkgs ./treefmt.nix).config.build.wrapper
      );

      darwinConfigurations.${username} = darwin.lib.darwinSystem {
        inherit pkgs specialArgs;
        modules = [
          ./nix-darwin/default.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;
            home-manager.users.${actualUsername} = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = specialArgs;
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = specialArgs;
        modules = [
          { nix.package = pkgs.nix; }
          (import ./home-manager/home.nix)
        ];
      };
    };
}
