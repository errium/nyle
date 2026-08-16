{lib, ...}: {
  imports = [
    ./scheme.nix
  ];

  options.nyle = {
    enable = lib.mkEnableOption "nyle";
  };
}
