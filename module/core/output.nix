{lib, ...}: let
  inherit (lib.types) lazyAttrsOf raw submodule;
in {
  options.lib.nyle = lib.mkOption {
    type = submodule {freeformType = lazyAttrsOf raw;};
    default = {};
    description = "Computed values produced by nyle (palette, generated target output, etc).";
  };
}
