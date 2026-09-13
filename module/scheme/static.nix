{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.nyle;

  base16Options = {
    base00 = mkOption {type = types.str;};
    base01 = mkOption {type = types.str;};
    base02 = mkOption {type = types.str;};
    base03 = mkOption {type = types.str;};
    base04 = mkOption {type = types.str;};
    base05 = mkOption {type = types.str;};
    base06 = mkOption {type = types.str;};
    base07 = mkOption {type = types.str;};
    base08 = mkOption {type = types.str;};
    base09 = mkOption {type = types.str;};
    base0A = mkOption {type = types.str;};
    base0B = mkOption {type = types.str;};
    base0C = mkOption {type = types.str;};
    base0D = mkOption {type = types.str;};
    base0E = mkOption {type = types.str;};
    base0F = mkOption {type = types.str;};
  };

  base24Options =
    base16Options
    // {
      base10 = mkOption {type = types.str;};
      base11 = mkOption {type = types.str;};
      base12 = mkOption {type = types.str;};
      base13 = mkOption {type = types.str;};
      base14 = mkOption {type = types.str;};
      base15 = mkOption {type = types.str;};
      base16 = mkOption {type = types.str;};
      base17 = mkOption {type = types.str;};
    };

  base16ToBase24 = colors:
    colors
    // {
      base10 = colors.base00;
      base11 = colors.base01;
      base12 = colors.base02;
      base13 = colors.base03;
      base14 = colors.base0A;
      base15 = colors.base0B;
      base16 = colors.base0C;
      base17 = colors.base0D;
    };
in {
  options.nyle.scheme = {
    base16 = mkOption {
      type = types.nullOr (types.submodule {options = base16Options;});
      default = null;
      description = "A scheme following the base16 standard.";
    };

    base24 = mkOption {
      type = types.nullOr (types.submodule {options = base24Options;});
      default = null;
      description = "A scheme following the base24 standard.";
    };
  };

  config = mkIf (cfg.scheme.base16 != null || cfg.scheme.base24 != null) {
    # FIX: Naming
    nyle.colors =
      if cfg.scheme.base24 != null
      then cfg.scheme.base24
      else base16ToBase24 cfg.scheme.base16;
  };
}
