{lib, ...}: {
  imports = [
    ./assertion.nix
    ./lib.nix
    ./mk-target.nix
    ./options.nix
    ./semantic.nix

    ./scheme

    (lib.filesystem.listFilesRecursive ../targets)
  ];
}
