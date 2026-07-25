{lib, ...}: let
  hexType = lib.types.strMatching "^#[0-9a-fA-F]{6}$";
  hex = lib.mkOption {type = hexType;};
  hexOptional = lib.mkOption {
    type = lib.types.nullOr hexType;
    default = null;
  };

  extraSlots = {
    base10 = "base00";
    base11 = "base00";
    base12 = "base08";
    base13 = "base0A";
    base14 = "base0B";
    base15 = "base0C";
    base16 = "base0D";
    base17 = "base0E";
  };
in {
  options.nyle.scheme = lib.mkOption {
    # TODO: better description
    description = ''
      base24 color scheme with 24 slots (base00–base17) and a variant field.

      Provide base00–base0F for a base16 scheme — base10–base17 are auto-filled.
      Provide all 24 for full base24 control.
      Providing only some base10–base17 results in an error.
    '';

    type = lib.types.submodule {
      options = {
        variant = lib.mkOption {
          type = lib.types.enum ["dark" "light"];
          # TODO: better description
          description = "Scheme variant. Dark means base00 is darkest, light means base00 is lightest.";
        };

        base00 = hex;
        base01 = hex;
        base02 = hex;
        base03 = hex;
        base04 = hex;
        base05 = hex;
        base06 = hex;
        base07 = hex;
        base08 = hex;
        base09 = hex;
        base0A = hex;
        base0B = hex;
        base0C = hex;
        base0D = hex;
        base0E = hex;
        base0F = hex;
        base10 = hexOptional;
        base11 = hexOptional;
        base12 = hexOptional;
        base13 = hexOptional;
        base14 = hexOptional;
        base15 = hexOptional;
        base16 = hexOptional;
        base17 = hexOptional;
      };
    };

    # TODO: revisit
    apply = scheme: let
      defined = lib.filter (s: scheme.${s} != null) (builtins.attrNames extraSlots);
      count = builtins.length defined;
    in
      if count == 0
      then scheme // lib.mapAttrs (_: k: scheme.${k}) extraSlots
      else if count == 8
      then scheme
      else
        throw ''
          nyle.scheme: base10–base17 must be either all 8 (base24) or none (base16) —
          got ${toString count}/8 defined.
        '';
  };
}
