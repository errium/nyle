# TODO: Rewrite
{lib}: let
  inherit (import ./mnemonic.nix {}) mkMnemonic;
  inherit (import ./semantic.nix {}) mkSemantic;
  conversions = import ./conversions.nix {inherit lib;};

  representations = raw: {
    inherit raw;
    hex = conversions.toHex raw;
    rgb = conversions.toRgb raw;
  };
in {
  mkPalette = schemeNormalized: let
    mnemonicRaw = mkMnemonic schemeNormalized;
    semanticRaw = mkSemantic mnemonicRaw;
  in {
    inherit (schemeNormalized) variant;
    base = representations (removeAttrs schemeNormalized ["variant"]);
    mnemonic = representations mnemonicRaw;
    semantic = representations semanticRaw;
  };
}
