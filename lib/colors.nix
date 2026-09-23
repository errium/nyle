# TODO: Rewrite
{lib}: let
  # hex -> rgb() conversion
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

  hexPairToDec = pair: let
    lower = lib.toLower pair;
  in
    hexDigits.${builtins.substring 0 1 lower}
    * 16
    + hexDigits.${builtins.substring 1 1 lower};

  hexToRgb = h: let
    r = hexPairToDec (builtins.substring 0 2 h);
    g = hexPairToDec (builtins.substring 2 2 h);
    b = hexPairToDec (builtins.substring 4 2 h);
  in "rgb(${toString r},${toString g},${toString b})";

  toHex = colors: lib.mapAttrs (_: v: "#" + v) colors;
  toRgb = colors: lib.mapAttrs (_: v: hexToRgb v) colors;

  base16ToBase24 = colors:
    colors
    // {
      base10 = colors.base00;
      base11 = colors.base00;
      base12 = colors.base08;
      base13 = colors.base0A;
      base14 = colors.base0B;
      base15 = colors.base0C;
      base16 = colors.base0D;
      base17 = colors.base0E;
    };

  toMnemonic = colors: {
    red = colors.base08;
    orange = colors.base09;
    yellow = colors.base0A;
    green = colors.base0B;
    cyan = colors.base0C;
    blue = colors.base0D;
    magenta = colors.base0E;
    brown = colors.base0F;
    brightRed = colors.base12;
    brightYellow = colors.base13;
    brightGreen = colors.base14;
    brightCyan = colors.base15;
    brightBlue = colors.base16;
    brightMagenta = colors.base17;
  };

  # TODO: Finish
  toSemantic = mnemonic: {
    accent = mnemonic.blue;
    error = mnemonic.red;
    warning = mnemonic.brown;
    success = mnemonic.green;
  };
in {inherit hexToRgb toHex toRgb base16ToBase24 toMnemonic toSemantic;}
