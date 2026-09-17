# TODO: Revisit, move
{
  hjem,
  pkgs,
  self,
}: let
  inherit (pkgs) lib;
  hjem-lib = import (hjem + "/lib.nix") {inherit lib pkgs;};

  # https://github.com/tinted-theming/schemes/blob/spec-0.11/base16/chalk.yaml
  scheme = {
    variant = "dark";
    base00 = "121212";
    base01 = "929292";
    base02 = "bdbdbd";
    base03 = "c5c5c5";
    base04 = "cdcdcd";
    base05 = "d5d5d5";
    base06 = "dedede";
    base07 = "ffffff";
    base08 = "e27373";
    base09 = "ffba7b";
    base0A = "b1d8f6";
    base0B = "93b979";
    base0C = "00988e";
    base0D = "97bedc";
    base0E = "e1c0fa";
    base0F = "713939";
  };

  # TODO: Rename (??)
  hjemUserModule = {
    _module.args.name = "test";
    user = "test";
    directory = "/home/test";
  };

  nyleConfig = {
    nyle.enable = true;
    nyle.mode = "all";
    nyle.scheme.base16 = scheme;
  };

  evaluation = lib.evalModules {
    class = "hjem";
    specialArgs = {inherit hjem-lib pkgs;};
    modules = [
      (hjem + "/modules/common/user.nix")
      hjemUserModule
      self.hjemModules.nyle
      nyleConfig
    ];
  };
in {
  check =
    builtins.deepSeq evaluation.config.nyle
    (builtins.deepSeq evaluation.config.lib.nyle true);
}
