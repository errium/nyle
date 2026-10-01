{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.nyle;
  conversions = import ../../lib/conversions.nix {inherit lib;};

  hex = types.strMatching "^[0-9A-Fa-f]{6}$";
  hasBase16 = cfg.scheme.base16 != null;
  hasBase24 = cfg.scheme.base24 != null;

  base16Options = {
    variant = mkOption {type = types.enum ["light" "dark"];};
    base00 = mkOption {type = hex;};
    base01 = mkOption {type = hex;};
    base02 = mkOption {type = hex;};
    base03 = mkOption {type = hex;};
    base04 = mkOption {type = hex;};
    base05 = mkOption {type = hex;};
    base06 = mkOption {type = hex;};
    base07 = mkOption {type = hex;};
    base08 = mkOption {type = hex;};
    base09 = mkOption {type = hex;};
    base0A = mkOption {type = hex;};
    base0B = mkOption {type = hex;};
    base0C = mkOption {type = hex;};
    base0D = mkOption {type = hex;};
    base0E = mkOption {type = hex;};
    base0F = mkOption {type = hex;};
  };

  base24Options =
    base16Options
    // {
      base10 = mkOption {type = hex;};
      base11 = mkOption {type = hex;};
      base12 = mkOption {type = hex;};
      base13 = mkOption {type = hex;};
      base14 = mkOption {type = hex;};
      base15 = mkOption {type = hex;};
      base16 = mkOption {type = hex;};
      base17 = mkOption {type = hex;};
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

  config = mkIf (cfg.enable && (hasBase16 || hasBase24)) {
    nyle._schemeNormalized =
      if hasBase24
      then cfg.scheme.base24
      else conversions.base16ToBase24 cfg.scheme.base16;
  };
}
