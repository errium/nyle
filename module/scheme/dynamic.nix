{
  config,
  lib,
  ...
}: let
  inherit (config) nyle;
  inherit (lib) mkIf mkOption types;

  dynamicOptions = {};
in {
  options.nyle.scheme.dynamic = mkOption {
    type = types.nullOr (types.submodule {options = dynamicOptions;});
    default = null;
    description = "WIP"; # TODO
  };

  config.internal.resolved =
    mkIf (nyle.enable && nyle.scheme.dynamic != null)
    nyle.scheme.dynamic;
}
