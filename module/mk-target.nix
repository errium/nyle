{
  config,
  lib,
  pkgs,
  ...
}: {
  mkTarget = {
    name,
    generate,
    linkPath ? null,
  }: let
    cfg = config.nyle.targets.${name};
  in {
    options.nyle.targets.${name} =
      {
        enable = lib.mkEnableOption "theme generation for ${name}";

        generated = lib.mkOption {
          type = lib.types.path;
          readOnly = true;
          description = "Store path of the generated ${name} theme.";
        };
      }
      // lib.optionalAttrs (linkPath != null) {
        link = lib.mkOption {
          type = lib.types.bool;
          description = "Whether to link the theme into ${linkPath}.";
          default = false;
        };
      };

    config = lib.mkIf (config.nyle.enable && cfg.enable) {
      nyle.targets.${name}.generated = pkgs.writeText name (generate {
        inherit (config.nyle) scheme;
      });

      files = lib.mkIf (linkPath != null && cfg.link) {
        ${linkPath}.source = cfg.generated;
      };
    };
  };
}
