{
  config,
  lib,
  ...
}: let
  inherit (config) nyle;
  inherit (lib) mkOption types;

  targetOptions.options = {
    enable = mkOption {
      type = types.bool;
      default = nyle.enable && nyle.mode == "all";
      description = ''
        Whether this target is enabled.
        Defaults to `true` when `nyle.mode` is set to `all`.
      '';
    };

    template = mkOption {
      type = types.str;
      internal = true;
      visible = false;
    };
  };
in {
  options.nyle.targets = mkOption {
    type = types.attrsOf (types.submodule targetOptions);
    default = {};
  };
}
