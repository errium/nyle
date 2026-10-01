{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) enum nullOr strMatching submodule;

  hexType = strMatching "^[0-9A-Fa-f]{6}$";

  slotOptions = {
    base00 = mkOption {type = hexType;};
    base01 = mkOption {type = hexType;};
    base02 = mkOption {type = hexType;};
    base03 = mkOption {type = hexType;};
    base04 = mkOption {type = hexType;};
    base05 = mkOption {type = hexType;};
    base06 = mkOption {type = hexType;};
    base07 = mkOption {type = hexType;};
    base08 = mkOption {type = hexType;};
    base09 = mkOption {type = hexType;};
    base0A = mkOption {type = hexType;};
    base0B = mkOption {type = hexType;};
    base0C = mkOption {type = hexType;};
    base0D = mkOption {type = hexType;};
    base0E = mkOption {type = hexType;};
    base0F = mkOption {type = hexType;};
    base10 = mkOption {type = hexType;};
    base11 = mkOption {type = hexType;};
    base12 = mkOption {type = hexType;};
    base13 = mkOption {type = hexType;};
    base14 = mkOption {type = hexType;};
    base15 = mkOption {type = hexType;};
    base16 = mkOption {type = hexType;};
    base17 = mkOption {type = hexType;};
  };

  _schemeNormalizedType = nullOr (submodule {
    options = slotOptions // {variant = mkOption {type = enum ["light" "dark"];};};
  });
in {
  options.nyle._schemeNormalized = mkOption {
    type = _schemeNormalizedType;
    default = null;
    description = "WIP"; # TODO
    internal = true;
    visible = false;
  };
}
