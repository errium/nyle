{lib, ...}: {
  imports =
    [
      ./core/options.nix
      ./core/output.nix
      ./core/palette.nix
      ./core/targets.nix

      ./scheme/assertions.nix
      ./scheme/resolved.nix
      ./scheme/static.nix
    ]
    ++ lib.filesystem.listFilesRecursive ../targets;
}
