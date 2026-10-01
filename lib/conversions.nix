{lib}: let
  inherit (builtins) substring;
  inherit (lib) mapAttrs toLower;

  hexDigits = {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
    a = 10;
    b = 11;
    c = 12;
    d = 13;
    e = 14;
    f = 15;
  };

  hexByteToInt = byte:
    hexDigits.${substring 0 1 (toLower byte)}
    * 16
    + hexDigits.${substring 1 1 (toLower byte)};

  hexToRgb = hex: let
    r = toString (hexByteToInt (substring 0 2 hex));
    g = toString (hexByteToInt (substring 2 2 hex));
    b = toString (hexByteToInt (substring 4 2 hex));
  in "rgb(${r}, ${g}, ${b})";

  # TODO: Naming
  # https://github.com/tinted-theming/base24/blob/master/styling.md
  base16ToBase24 = s:
    s
    // {
      base10 = s.base00;
      base11 = s.base00;
      base12 = s.base08;
      base13 = s.base0A;
      base14 = s.base0B;
      base15 = s.base0C;
      base16 = s.base0D;
      base17 = s.base0E;
    };
in {
  inherit base16ToBase24;
  # TODO: Naming
  toHex = colors: mapAttrs (_: v: "#" + v) colors;
  toRgb = colors: mapAttrs (_: v: hexToRgb v) colors;
}
