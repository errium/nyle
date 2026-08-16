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
  };
}
