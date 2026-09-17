{lib, ...}: {
  imports =
    [
      ./lib.nix
      ./mk-target.nix
      ./options.nix

      ./scheme
    ]
    ++ lib.filesystem.listFilesRecursive ../targets;
}
