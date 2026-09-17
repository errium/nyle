{
  description = "nyle";

  outputs = {self, ...}: {
    hjemModules = {
      nyle = ./module; # TODO: ./module autoimport??
      default = self.hjemModules.nyle;
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
