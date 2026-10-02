{
  description = "nyle";

  outputs = {
    self,
    hjem,
    nixpkgs,
    ...
  }: let
    eachSystem = nixpkgs.lib.genAttrs ["aarch64-linux" "x86_64-linux"];
    pkgsOf = nixpkgs.legacyPackages;
  in {
    hjemModules = {
      nyle = ./module;
      default = self.hjemModules.nyle;
    };

    # nix flake check
    checks = eachSystem (system:
      import ./testing/eval.nix {
        inherit self hjem;
        pkgs = pkgsOf.${system};
      });
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hjem.url = "github:feel-co/hjem";
    hjem.inputs.nixpkgs.follows = "nixpkgs";
  };
}
