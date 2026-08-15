{
  description = "nyle";

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    hjemModules = {
      nyle = ./module;
      default = self.hjemModules.nyle;
    };

    checks.x86_64-linux.nyle = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
      pkgs.linkFarm "nyle-check" (import ./tests/eval.nix {inherit (nixpkgs) lib;});
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
