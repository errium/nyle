{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./scheme.nix
    ../targets
  ];

  options.nyle = {
    enable = lib.mkEnableOption "nyle";
  };

  config = {
    _module.args.mkTarget = (import ./mk-target.nix {inherit config lib pkgs;}).mkTarget;
  };
}
