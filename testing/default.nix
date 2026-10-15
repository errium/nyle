/*
Internal test data, freeform: anything can be put under `internal.testing`.
Lives outside module/, so nyle itself never imports it.
*/
{lib, ...}: {
  options.internal.testing = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = {};
    description = "Internal test data.";
    internal = true;
    visible = false;
  };

  config.internal.testing = {
    # https://github.com/tinted-theming/schemes/blob/spec-0.11/base16/ayu-dark.yaml
    base16Dark = {
      variant = "dark";
      base00 = "0b0e14";
      base01 = "131721";
      base02 = "202229";
      base03 = "3e4b59";
      base04 = "bfbdb6";
      base05 = "e6e1cf";
      base06 = "ece8db";
      base07 = "f2f0e7";
      base08 = "f07178";
      base09 = "ff8f40";
      base0A = "ffb454";
      base0B = "aad94c";
      base0C = "95e6cb";
      base0D = "59c2ff";
      base0E = "d2a6ff";
      base0F = "e6b450";
    };
  };
}
