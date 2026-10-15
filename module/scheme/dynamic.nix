{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  inherit (config) nyle;
in {
  options.nyle.scheme.dynamic = mkOption {
    type = types.nullOr (types.submodule {
      options.image = mkOption {
        type = types.path;
        description = "Source image to generate a color scheme from.";
      };
    });
    default = null;
    description = "Generate a color scheme from an image. Not implemented yet.";
  };

  config.lib.nyle = mkIf (nyle.enable && nyle.scheme.dynamic != null) (
    throw "nyle: dynamic scheme generation is not implemented yet."
  );
}
