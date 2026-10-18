/*
A basic eval test for nyle.

Evaluates nyle as a hjem user module,
checks representative palette values and forces the whole output.

Targets are discovered, so adding one needs no edits here.
*/
{
  hjem,
  pkgs,
  self,
}: let
  inherit (pkgs) lib;
  hjem-lib = import (hjem + "/lib.nix") {inherit lib pkgs;};

  # nyle as a hjem user module, with all targets enabled.
  evaluation = lib.evalModules {
    class = "hjem";
    specialArgs = {inherit hjem-lib pkgs;};
    modules = [
      (hjem + "/modules/common/user.nix")
      {
        _module.args.name = "test";
        user = "test";
        directory = "/home/test";
      }
      ./default.nix
      self.hjemModules.nyle
      ({config, ...}: {
        nyle.enable = true;
        nyle.mode = "all";
        nyle.scheme.base16 = config.internal.testing.base16Dark;
      })
    ];
  };

  # Input scheme, published palette and every generated target output.
  scheme = evaluation.config.internal.testing.base16Dark;
  palette = evaluation.config.lib.nyle;
  outputs = lib.attrValues palette.generated;

  # Each check is a boolean; the failed ones are reported by name.
  checks = {
    base24Fallbacks = lib.all (ok: ok) [
      (palette.base.raw.base10 == scheme.base00)
      (palette.base.raw.base11 == scheme.base00)
      (palette.base.raw.base12 == scheme.base08)
      (palette.base.raw.base13 == scheme.base0A)
      (palette.base.raw.base14 == scheme.base0B)
      (palette.base.raw.base15 == scheme.base0C)
      (palette.base.raw.base16 == scheme.base0D)
      (palette.base.raw.base17 == scheme.base0E)
    ];

    # WARN: Hardcode.
    hex = palette.base.hex.base00 == "#0b0e14";
    rgb = palette.base.rgb.base00 == "rgb(11, 14, 20)";

    mnemonic = lib.all (ok: ok) [
      (palette.mnemonic.raw.red == scheme.base08)
      (palette.mnemonic.raw.white == scheme.base05)
    ];

    # Every target output must evaluate to a string.
    generated = outputs != [] && lib.all builtins.isString outputs;
  };

  # Names of the checks that did not pass.
  failed = lib.attrNames (lib.filterAttrs (_: passed: !passed) checks);
in {
  # deepSeq forces the whole palette, so errors inside the module system surface.
  check = pkgs.runCommand "nyle-eval" {} ''
    echo ${toString (
      if failed == []
      then builtins.deepSeq palette true
      else throw "nyle eval checks failed: ${toString failed}"
    )} > $out
  '';
}
