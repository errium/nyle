{lib, ...}: let
  hex = lib.mkOption {type = lib.types.strMatching "^#[0-9a-fA-F]{6}$";};
in {
  options.nyle.scheme = lib.mkOption {
    description = "WIP";
    type = lib.types.submodule {
      options = {
        variant = lib.mkOption {
          description = "WIP";
          type = lib.types.enum ["dark" "light"];
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
        base10 = hex;
        base11 = hex;
        base12 = hex;
        base13 = hex;
        base14 = hex;
        base15 = hex;
        base16 = hex;
        base17 = hex;
      };
    };
  };
}
