# TODO: Rewrite, simplify
{lib, ...}: {
  options.lib.nyle = lib.mkOption {
    type = lib.types.submodule {
      freeformType = lib.types.lazyAttrsOf lib.types.raw;
    };
    default = {};
    description = "Computed values produced by nyle.";
  };
}
