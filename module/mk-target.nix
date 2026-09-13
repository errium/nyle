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
      (lib.mkIf (cfg.targetActivation == "all") {enable = lib.mkForce true;})
      {
        generated =
          if cfg.targetActivation == "manual" && !cfg.targets.${name}.enable
          then throw ''nyle: "${name}" target is not enabled.''
          else template cfg.colors; # WARN
      }
    ];
  };
in {_module.args.nyleTarget = mkTarget;}
