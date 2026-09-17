let
  mkTarget = {
    name,
    template,
  }: {
    config,
    lib,
    ...
  }: let
    cfg = config.nyle;
  in {
    options.nyle.targets.${name} = {
      enable = lib.mkEnableOption "${name} target";

      generated = lib.mkOption {
        type = lib.types.str;
        description = "Generated configuration for the ${name} target.";
        readOnly = true;
      };
    };

    config.nyle.targets.${name} = lib.mkMerge [
      (lib.mkIf (cfg.enable && cfg.mode == "all") {enable = lib.mkForce true;})
      {
        generated =
          if !cfg.enable
          then throw "nyle: nyle.enable is false."
          else if cfg.mode == "manual" && !cfg.targets.${name}.enable
          then throw ''nyle: "${name}" target is not enabled.''
          else template config.lib.nyle.colors; # WARN: lib.nyle.colors
      }
    ];
  };
in {
  # TODO: Rename??
  _module.args.mkTarget = mkTarget;
}
