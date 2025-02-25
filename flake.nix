{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    chrultrabook-tools = {
      url = "github:death7654/chrultrabook-tools";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
      chrultrabook-tools,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixfmt-rfc-style
          ];
        };

        packages = import ./pkgs nixpkgs.legacyPackages.${system} // {
          chrultrabook-tools = chrultrabook-tools.packages.${system}.default;
        };

        nixosModules = {
          default =
            { ... }:
            {
              nixpkgs.overlays = [ self.overlays.default ];
              imports = [
                ./modules/default
              ];
            };
          setuidWrappers = import ./modules/setuid { inherit pkgs; };
        };

      }
    )
    // {
      overlays.default = final: prev: import ./pkgs { pkgs = prev.pkgs; };
    };
}
