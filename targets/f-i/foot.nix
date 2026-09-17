# TODO: Naming?
{mkTarget, ...}:
mkTarget {
  name = "foot";

  template = scheme:
    with scheme.raw; ''
      [colors-${scheme.variant}]
      foreground=${base05}
      background=${base00}

      regular0=${base00}
      regular1=${base08}
      regular2=${base0B}
      regular3=${base0A}
      regular4=${base0D}
      regular5=${base0E}
      regular6=${base0C}
      regular7=${base05}

      bright0=${base10}
      bright1=${base12}
      bright2=${base14}
      bright3=${base13}
      bright4=${base16}
      bright5=${base17}
      bright6=${base15}
      bright7=${base07}

      16=${base09}
      17=${base0F}
    '';
}
