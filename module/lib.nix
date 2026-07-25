{
  config,
  lib,
  pkgs,
}: {
  mkTarget = {
    name, # application name, e.g. "foot"
    generate, # takes the active scheme, returns the target's full config text
    linkPath, # where `generated` gets linked to, if link = true
  }: let
    cfg = config.nyle.targets.${name};
  in {
    options.nyle.targets.${name} = {
      enable = lib.mkEnableOption "theme generation for ${name}";

      generated = lib.mkOption {
        type = lib.types.path;
        readOnly = true;
        description = "Store path of the generated ${name} theme.";
      };

      link = lib.mkOption {
        type = lib.types.bool;
        description = "Whether to link the theme into ${linkPath}.";
        default = false;
      };
    };

    config = lib.mkIf cfg.enable {
      nyle.targets.${name}.generated = pkgs.writeText name (
        generate {inherit (config.nyle) scheme;}
      );

      files.${linkPath} = lib.mkIf cfg.link {
        source = cfg.generated;
      };
    };
  };
}
