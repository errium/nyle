# TODO: Move, refactor
{
  config,
  lib,
  ...
}: let
  colorsLib = import ../../lib/palette.nix {inherit lib;};
in {
  config.lib.nyle = lib.mkIf (config.nyle._schemeNormalized != null) (
    colorsLib.mkPalette config.nyle._schemeNormalized
  );
}
