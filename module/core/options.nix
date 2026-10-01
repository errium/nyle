{lib, ...}: {
  options.nyle = {
    enable = lib.mkEnableOption "nyle";

    mode = lib.mkOption {
      type = lib.types.enum ["all" "lazy" "manual"];
      default = "manual";
      description = ''
        Determines how targets are activated:

        - all: all targets are enabled.
        - lazy: targets are activated on first use.
        - manual: targets must be enabled explicitly.
      '';
    };
  };
}
