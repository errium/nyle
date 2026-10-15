/*
Map base24 slots to human-readable color names.

Takes an attrset with base00..base17 (raw hex, base24 form)
and only renames slots, values are passed through unchanged.

https://github.com/tinted-theming/base24/blob/main/styling.md#specific-colors-and-their-usages
*/
_: {
  mkMnemonic = base24: {
    # Backgrounds
    black = base24.base00;
    darkestGray = base24.base01;
    darkGray = base24.base02;
    gray = base24.base03;

    # Foregrounds
    lightGray = base24.base04;
    white = base24.base05;
    lighterWhite = base24.base06;
    brightWhite = base24.base07;

    # Accents
    red = base24.base08;
    orange = base24.base09;
    yellow = base24.base0A;
    green = base24.base0B;
    cyan = base24.base0C;
    blue = base24.base0D;
    magenta = base24.base0E;
    brown = base24.base0F;

    # Base24 extension slots
    darkerBlack = base24.base10;
    darkestBlack = base24.base11;
    brightRed = base24.base12;
    brightYellow = base24.base13;
    brightGreen = base24.base14;
    brightCyan = base24.base15;
    brightBlue = base24.base16;
    brightMagenta = base24.base17;
  };
}
