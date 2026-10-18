/*
Internal meeting point between scheme inputs and output.

Each input writes its result here as variant + base00..base17.
Values are not re-validated: the inputs' own option types should check them.
*/
{lib, ...}: {
  options.internal.resolved = lib.mkOption {
    type = lib.types.nullOr (lib.types.attrsOf lib.types.str);
    default = null;
    description = "Chosen scheme in base24 form (variant + base00..base17).";
    internal = true;
    visible = false;
  };
}
