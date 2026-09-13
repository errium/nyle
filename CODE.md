### /flake.nix:

```nix
{
  description = "nyle";

  outputs = {self, ...}: {
    hjemModules = {
      nyle = ./module; # TODO: ./module autoimport??
      default = self.hjemModules.nyle;
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}

```

### /module/default.nix:

```nix
{
  imports = [
    ./lib.nix
    ./mk-target.nix # WARN
    ./options.nix
    ./scheme/dynamic.nix
    ./scheme/static.nix
    ./semantic.nix
  ];
}

```

### /module/lib.nix:

```nix
{lib, ...}: {
  # FIXME
  options.lib.nyle = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
    description = "Computed values produced by nyle.";
  };
}

```

### /module/mk-target.nix:

```nix
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

```

### /module/options.nix:

```nix
{lib, ...}: {
  options.nyle = {
    enable = lib.mkEnableOption "nyle";

    mode = lib.mkOption {
      type = lib.types.enum ["all" "lazy" "manual"];
      default = "manual";
      description = ''
        Determines how targets are activated:

        - all: all targets are enabled.
        - lazy: targets are activated on first use.
        - manual: targets must be enabled explicitly.
      '';
    };
  };
}

```

### /module/scheme/dynamic.nix:

```nix
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

```

### /module/scheme/static.nix:

```nix
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.nyle;

  base16Options = {
    base00 = mkOption {type = types.str;};
    base01 = mkOption {type = types.str;};
    base02 = mkOption {type = types.str;};
    base03 = mkOption {type = types.str;};
    base04 = mkOption {type = types.str;};
    base05 = mkOption {type = types.str;};
    base06 = mkOption {type = types.str;};
    base07 = mkOption {type = types.str;};
    base08 = mkOption {type = types.str;};
    base09 = mkOption {type = types.str;};
    base0A = mkOption {type = types.str;};
    base0B = mkOption {type = types.str;};
    base0C = mkOption {type = types.str;};
    base0D = mkOption {type = types.str;};
    base0E = mkOption {type = types.str;};
    base0F = mkOption {type = types.str;};
  };

  base24Options =
    base16Options
    // {
      base10 = mkOption {type = types.str;};
      base11 = mkOption {type = types.str;};
      base12 = mkOption {type = types.str;};
      base13 = mkOption {type = types.str;};
      base14 = mkOption {type = types.str;};
      base15 = mkOption {type = types.str;};
      base16 = mkOption {type = types.str;};
      base17 = mkOption {type = types.str;};
    };

  base16ToBase24 = colors:
    colors
    // {
      base10 = colors.base00;
      base11 = colors.base01;
      base12 = colors.base02;
      base13 = colors.base03;
      base14 = colors.base0A;
      base15 = colors.base0B;
      base16 = colors.base0C;
      base17 = colors.base0D;
    };
in {
  options.nyle.scheme = {
    base16 = mkOption {
      type = types.nullOr (types.submodule {options = base16Options;});
      default = null;
      description = "A scheme following the base16 standard.";
    };

    base24 = mkOption {
      type = types.nullOr (types.submodule {options = base24Options;});
      default = null;
      description = "A scheme following the base24 standard.";
    };
  };

  config = mkIf (cfg.scheme.base16 != null || cfg.scheme.base24 != null) {
    # FIX: Naming
    nyle.colors =
      if cfg.scheme.base24 != null
      then cfg.scheme.base24
      else base16ToBase24 cfg.scheme.base16;
  };
}

```

### /module/semantic.nix:

```nix
{
  # STUB
}

```
