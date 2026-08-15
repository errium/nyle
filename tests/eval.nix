{lib}: let
  scheme = {
    variant = "dark";
    base00 = "#1e1e2e";
    base01 = "#181825";
    base02 = "#313244";
    base03 = "#45475a";
    base04 = "#585b70";
    base05 = "#cdd6f4";
    base06 = "#f5e0dc";
    base07 = "#b4befe";
    base08 = "#f38ba8";
    base09 = "#fab387";
    base0A = "#f9e2af";
    base0B = "#a6e3a1";
    base0C = "#94e2d5";
    base0D = "#89b4fa";
    base0E = "#f5c2e7";
    base0F = "#f2cdcd";
    base10 = null;
    base11 = null;
    base12 = null;
    base13 = null;
    base14 = null;
    base15 = null;
    base16 = null;
    base17 = null;
  };

  targetModules = builtins.filter (p: p != ../targets/default.nix) (
    lib.filesystem.listFilesRecursive ../targets
  );
  targetNames = map (p: lib.removeSuffix ".nix" (baseNameOf p)) targetModules;

  enableAll = lib.genAttrs targetNames (_: {enable = true;});

  evaluated = lib.evalModules {
    modules = [
      ../module
      {
        nyle.scheme = scheme;
        nyle.targets = enableAll;
      }
    ];
  };

  forced = lib.mapAttrs (_: t: t.generated) evaluated.config.nyle.targets;
in
  forced
