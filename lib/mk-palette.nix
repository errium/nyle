{lib}: let
  inherit (import ./conversions.nix {inherit lib;}) toHex toRgb;
  inherit (import ./mk-mnemonic.nix {}) mkMnemonic;
  inherit (import ./mk-semantic.nix {}) mkSemantic;

  # Attrset of raw colors -> same colors in all three representations.
  representations = rawColors: {
    raw = rawColors;
    hex = toHex rawColors;
    rgb = toRgb rawColors;
  };
in {
  mkPalette = resolved: rec {
    inherit (resolved) variant;
    base = representations (removeAttrs resolved ["variant"]);
    mnemonic = representations (mkMnemonic resolved);
    semantic = representations (mkSemantic mnemonic.raw);
  };
}
