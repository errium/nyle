{
  config,
  lib,
  ...
}: let
  inherit (config) nyle;
  inherit (import ../../lib/conversions.nix {inherit lib;}) toBase24;
  inherit (lib) mkIf mkOption types;

  hex = types.strMatching "^[0-9A-Fa-f]{6}$";

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

  # Input-specific step: turn whichever scheme input the user set into `nyle.resolved` (base24 form).
  # If several inputs are set, base24 wins silently; the assertion in assertions.nix reports it.
  config.nyle.resolved = mkIf (nyle.enable && (nyle.scheme.base24 != null || nyle.scheme.base16 != null)) (
    if nyle.scheme.base24 != null
    then nyle.scheme.base24
    else toBase24 nyle.scheme.base16
  );
}
