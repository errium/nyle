{lib, ...}: {
  options.nyle = {
    enable = lib.mkEnableOption "nyle";

    mode = lib.mkOption {
      type = lib.types.enum ["all" "lazy" "manual"];
      default = "manual";
      description = ''
        How targets become active.
        - `all`: every imported target is active.
        - `lazy`: a target is active as soon as its output is referenced.
        - `manual`: a target is active only if `nyle.targets.<name>.enable` is set.
      '';
    };
  };
}
