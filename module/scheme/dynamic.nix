# TODO: Format
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.nyle;

  dynamicOptions = {
    image = mkOption {
      type = types.path;
      description = "Source image to generate a color scheme from.";
    };

    scheme = mkOption {
      type = types.str;
      default = "mTonalSpot";
      description = "Matugen scheme variant to use.";
    };
  };

  hasDynamic = cfg.scheme.dynamic != null;
in {
  options.nyle.scheme.dynamic = mkOption {
    type = types.nullOr (types.submodule {options = dynamicOptions;});
    default = null;
    description = "Generate a color scheme from an image using matugen.";
  };

  config = mkIf (cfg.enable && hasDynamic) {
    lib.nyle.colors = throw "nyle: dynamic scheme generation is not implemented yet.";
  };
}
