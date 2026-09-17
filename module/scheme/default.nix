{
  config,
  lib,
  ...
}: let
  cfg = config.nyle;

  # TODO: Revisit this block
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
    )
    + (
      if cfg.scheme.dynamic != null
      then 1
      else 0
    );
in {
  imports = [
    ./dynamic.nix
    ./static.nix
  ];

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = inputCount == 1;
        # TODO: Message
        message = "nyle: exactly one of nyle.scheme.base16, nyle.scheme.base24, nyle.scheme.dynamic must be set (got ${toString inputCount}).";
      }
    ];
  };
}
