{
  config,
  lib,
  ...
}: let
  inherit (lib) mapAttrs mkEnableOption mkForce mkIf mkOption types;
  cfg = config.nyle;

  targetOptions = {
    enable = mkEnableOption "WIP";
    template = mkOption {
      type = types.functionTo types.str;
      internal = true;
      visible = false;
    };
  };
in {
  options.nyle.targets = mkOption {
    type = types.attrsOf (types.submodule {options = targetOptions;});
    default = {};
  };

  config.nyle.targets =
    mkIf (cfg.enable && cfg.mode == "all")
    (mapAttrs (_: _: {enable = mkForce true;}) cfg.targets);

  config.lib.nyle.generated =
    mapAttrs (
      name: target:
        if !cfg.enable
        then throw "nyle: nyle.enable is false."
        else if cfg.mode == "manual" && !target.enable
        then throw ''nyle: "${name}" target is not enabled.''
        else target.template config.lib.nyle
    )
    cfg.targets;
}
