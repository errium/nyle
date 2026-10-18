{
  config,
  lib,
  ...
}: let
  inherit (config) internal nyle;
  inherit (import ../../lib/mk-palette.nix {inherit lib;}) mkPalette;
  inherit (lib) mapAttrs mkIf mkMerge mkOption types;
in {
  options.lib.nyle = mkOption {
    type = types.lazyAttrsOf types.raw;
    default = {};
    description = "Computed values produced by nyle.";
  };

  config.lib.nyle = mkMerge [
    # Palette: variant, base, mnemonic, semantic. Absent until a scheme is resolved.
    (mkIf (internal.resolved != null) (mkPalette internal.resolved))

    # Rendered config string per target, keyed by target name.
    # Fails with a readable error if nyle or the target is not enabled.
    {
      generated =
        mapAttrs (
          name: target:
            if !nyle.enable
            then throw "nyle: nyle.enable is false."
            else if nyle.mode == "manual" && !target.enable
            then throw ''nyle: "${name}" target is not enabled.''
            else target.template
        )
        nyle.targets;
    }
  ];
}
