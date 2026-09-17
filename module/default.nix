{lib, ...}: let
  mkTarget = import ./mk-target.nix;
  targetFiles = lib.filesystem.listFilesRecursive ../targets;
  targets = map (path: mkTarget (import path)) targetFiles;
in {
  imports =
    [
      ./scheme

      ./lib.nix
      ./options.nix
    ]
    ++ targets;
}
