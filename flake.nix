{
  description = "nyle";

  outputs = {self, ...}: {
    hjemModules = {
      nyle = ./module;
      default = self.hjemModules.nyle;
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
