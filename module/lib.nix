{lib, ...}: {
  # FIXME
  options.lib.nyle = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
    description = "Computed values produced by nyle.";
  };
}
