{lib, ...}: {
  options.internal = lib.mkOption {
    type = lib.types.submodule {freeformType = lib.types.attrsOf lib.types.anything;};
    default = {};
    description = "Internal values shared by module components.";
    internal = true;
    visible = false;
  };
}
