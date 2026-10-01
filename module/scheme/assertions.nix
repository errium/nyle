# TODO: Rewrite
{
  config,
  lib,
  ...
}: let
  cfg = config.nyle;

  inputCount =
    (
      if cfg.scheme.base16 != null
      then 1
      else 0
    )
    + (
      if cfg.scheme.base24 != null
      then 1
      else 0
    );
in {
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = inputCount == 1;
        message = "nyle: exactly one of nyle.scheme.base16, nyle.scheme.base24 must be set (got ${toString inputCount}).";
      }
    ];
  };
}
