{
  description = "nyle";

  outputs = {self, ...} @ inputs: let
    forAllSystems = inputs.nixpkgs.lib.genAttrs ["aarch64-linux" "x86_64-linux"];
  in {
    hjemModules = {
      nyle = ./module; # TODO: ./module autoimport??
      default = self.hjemModules.nyle;
    };

    checks = forAllSystems (system:
      import ./module/eval.nix {
        inherit self;
        inherit (inputs) hjem;
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      });
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
