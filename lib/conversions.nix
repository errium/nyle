{lib}: let
  inherit (builtins) substring;
  inherit (lib) mapAttrs toLower;

  hexDigits = {
    "0" = 0; ## I
    "1" = 1; ## hate
    "2" = 2; ## all
    "3" = 3; ## nix
    "4" = 4; ## formatters
    "5" = 5; ## because
    "6" = 6; ## they
    "7" = 7; ## don't
    "8" = 8; ## let
    "9" = 9; ## me
    "a" = 10; # inline
    "b" = 11; # simple
    "c" = 12; # stuff
    "d" = 13; # like
    "e" = 14; # this
    "f" = 15; # >:(
  };

  hexByteToInt = byte:
    hexDigits.${substring 0 1 (toLower byte)}
    * 16
    + hexDigits.${substring 1 1 (toLower byte)};

  # One raw color string: "0b1621" -> "rgb(11, 22, 33)"
  rawToRgb = rawColor: let
    r = toString (hexByteToInt (substring 0 2 rawColor));
    g = toString (hexByteToInt (substring 2 2 rawColor));
    b = toString (hexByteToInt (substring 4 2 rawColor));
  in "rgb(${r}, ${g}, ${b})";

  # Fill base10..base17 from a base16 scheme, other attrs (e.g. `variant`) are kept.
  # https://github.com/tinted-theming/base24/blob/main/styling.md#base24-fallbacks
  toBase24 = base16:
    base16
    // {
      base10 = base16.base00;
      base11 = base16.base00;
      base12 = base16.base08;
      base13 = base16.base0A;
      base14 = base16.base0B;
      base15 = base16.base0C;
      base16 = base16.base0D;
      base17 = base16.base0E;
    };
in {
  inherit toBase24;

  # `rawColors`: attrset of color name -> raw color
  toHex = rawColors: mapAttrs (_: rawColor: "#" + rawColor) rawColors;
  toRgb = rawColors: mapAttrs (_: rawColor: rawToRgb rawColor) rawColors;
}
