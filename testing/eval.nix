{
  hjem,
  pkgs,
  self,
}: let
  inherit (pkgs) lib;
  hjem-lib = import (hjem + "/lib.nix") {inherit lib pkgs;};

  # https://github.com/tinted-theming/schemes/blob/spec-0.11/base24/chalk.yaml
  scheme = {
    variant = "dark";
    base00 = "#121212";
    base01 = "#929292";
    base02 = "#bdbdbd";
    base03 = "#c5c5c5";
    base04 = "#cdcdcd";
    base05 = "#d5d5d5";
    base06 = "#dedede";
    base07 = "#ffffff";
    base08 = "#e27373";
    base09 = "#ffba7b";
    base0A = "#b1d8f6";
    base0B = "#93b979";
    base0C = "#00988e";
    base0D = "#97bedc";
    base0E = "#e1c0fa";
    base0F = "#713939";
    base10 = "#7e7e7e";
    base11 = "#3f3f3f";
    base12 = "#ffa1a1";
    base13 = "#ffdca0";
    base14 = "#bddeab";
    base15 = "#1ab2a8";
    base16 = "#b1d8f6";
    base17 = "#fbdaff";
  };

  # Get the names of all available targets.
  targetNames =
    map
    (targetFile: (import targetFile) {mkTarget = {name, ...}: name;})
    (lib.filesystem.listFilesRecursive ../../targets);

  # Evaluate nyle with all targets enabled.
  evaluation = pkgs.lib.evalModules {
    class = "hjem";
    specialArgs = {inherit hjem-lib pkgs;};
    modules = [
      (hjem + "/modules/common/user.nix")
      {
        _module.args.name = "test";
        user = "test";
        directory = "/home/test";
      }
      self.hjemModules.nyle
      {
        nyle.enable = true;
        nyle.scheme = scheme;
        nyle.targets = lib.genAttrs targetNames (_: {enable = true;});
      }
    ];
  };
in {
  # Force evaluation.
  check = builtins.deepSeq evaluation.config.nyle true;
}
