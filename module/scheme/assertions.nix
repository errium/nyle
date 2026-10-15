{
  config,
  lib,
  ...
}: let
  inherit (config) nyle;
  sources = lib.attrNames nyle.scheme;
  set = lib.filter (name: nyle.scheme.${name} != null) sources;
in {
  config = lib.mkIf nyle.enable {
    assertions = [
      {
        assertion = lib.length set == 1;
        message = "nyle: set exactly one scheme source; got: ${
          if set == []
          then "none"
          else lib.concatStringsSep ", " set
        }.";
      }
    ];
  };
}
