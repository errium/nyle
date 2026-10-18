{
  config,
  lib,
  ...
}: let
  inherit (config) nyle;
  inherit (import ../../lib/conversions.nix {inherit lib;}) toBase24;
  inherit (lib) mkIf mkOption types;

  raw = types.strMatching "^[0-9A-Fa-f]{6}$";

  base16Options = {
    variant = mkOption {type = types.enum ["light" "dark"];};
    base00 = mkOption {type = raw;};
    base01 = mkOption {type = raw;};
    base02 = mkOption {type = raw;};
    base03 = mkOption {type = raw;};
    base04 = mkOption {type = raw;};
    base05 = mkOption {type = raw;};
    base06 = mkOption {type = raw;};
    base07 = mkOption {type = raw;};
    base08 = mkOption {type = raw;};
    base09 = mkOption {type = raw;};
    base0A = mkOption {type = raw;};
    base0B = mkOption {type = raw;};
    base0C = mkOption {type = raw;};
    base0D = mkOption {type = raw;};
    base0E = mkOption {type = raw;};
    base0F = mkOption {type = raw;};
  };

  base24Options =
    base16Options
    // {
      base10 = mkOption {type = raw;};
      base11 = mkOption {type = raw;};
      base12 = mkOption {type = raw;};
      base13 = mkOption {type = raw;};
      base14 = mkOption {type = raw;};
      base15 = mkOption {type = raw;};
      base16 = mkOption {type = raw;};
      base17 = mkOption {type = raw;};
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

  # Input-specific step: turn whichever scheme input the user set into `internal.resolved` (base24 form).
  # If several inputs are set, base24 wins silently; the assertion in assertions.nix reports it.
  config.internal.resolved = mkIf (nyle.enable && (nyle.scheme.base24 != null || nyle.scheme.base16 != null)) (
    if nyle.scheme.base24 != null
    then nyle.scheme.base24
    else toBase24 nyle.scheme.base16
  );
}
