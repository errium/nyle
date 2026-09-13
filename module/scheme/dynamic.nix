{
  config,
  lib,
  ...
}: let
  cfg = config.nyle;

  dynamicOptions = {
    image = lib.mkOption {
      type = lib.types.path;
      description = "Source image to generate a color scheme from.";
    };

    scheme = lib.mkOption {
      type = lib.types.str;
      default = "mTonalSpot";
      description = "Matugen scheme variant to use.";
    };
  };
in {
  options.nyle.scheme.dynamic = lib.mkOption {
    type = lib.types.nullOr (lib.types.submodule {options = dynamicOptions;});
    default = null;
    description = "Generate a color scheme from an image using matugen.";
  };

  config = lib.mkIf (cfg.scheme.dynamic != null) {
    nyle.colors = throw "nyle: dynamic scheme generation is not implemented yet.";
  };
}
