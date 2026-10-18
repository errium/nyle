{lib, ...}: {
  options.internal = lib.mkOption {
    type = lib.types.submodule ({lib, ...}: {
      freeformType = lib.types.attrsOf lib.types.anything;
    });
    default = {};
    description = "Internal values shared by module components.";
    internal = true;
    visible = false;
  };

  imports =
    [
      ./core/options.nix
      ./core/output.nix
      ./core/targets.nix

      ./scheme/assertions.nix
      ./scheme/resolved.nix
      ./scheme/static.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../targets;
}
