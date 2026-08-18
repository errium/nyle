{lib, ...}: {
  imports =
    [
      ./mk-target.nix
      ./scheme.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../targets;

  options.nyle.enable = lib.mkEnableOption "nyle";
}
