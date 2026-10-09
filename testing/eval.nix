{
  hjem,
  pkgs,
  self,
}: let
  inherit (pkgs) lib;
  hjemLib = import (hjem + "/lib.nix") {inherit lib pkgs;};

  # https://github.com/tinted-theming/schemes/blob/spec-0.11/base16/monokai.yaml
  scheme = {
    variant = "dark";
    base00 = "272822";
    base01 = "383830";
    base02 = "49483e";
    base03 = "75715e";
    base04 = "a59f85";
    base05 = "f8f8f2";
    base06 = "f5f4f1";
    base07 = "f9f8f5";
    base08 = "f92672";
    base09 = "fd971f";
    base0A = "f4bf75";
    base0B = "a6e22e";
    base0C = "a1efe4";
    base0D = "66d9ef";
    base0E = "ae81ff";
    base0F = "cc6633";
  };

  # Evaluate nyle with all targets enabled.
  evaluation = lib.evalModules {
    class = "hjem";
    specialArgs = {inherit hjemLib pkgs;};
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
        nyle.mode = "all";
        nyle.scheme.base16 = scheme;
      }
    ];
  };
in {
  # Force evaluation.
  check = pkgs.runCommand "nyle-eval" {} ''
    echo ${toString (builtins.deepSeq evaluation.config.lib.nyle true)} > $out
  '';
}
