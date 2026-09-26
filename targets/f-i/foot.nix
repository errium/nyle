{
  name = "foot";

  template = scheme:
    with scheme.mnemonic.raw; ''
      [colors-${scheme.variant}]
      foreground=${scheme.base.raw.base05}
      background=${scheme.base.raw.base00}

      regular0=${scheme.base.raw.base00}
      regular1=${red}
      regular2=${green}
      regular3=${yellow}
      regular4=${blue}
      regular5=${magenta}
      regular6=${cyan}
      regular7=${scheme.base.raw.base05}

      bright0=${scheme.base.raw.base10}
      bright1=${brightRed}
      bright2=${brightGreen}
      bright3=${brightYellow}
      bright4=${brightBlue}
      bright5=${brightMagenta}
      bright6=${brightCyan}
      bright7=${scheme.base.raw.base07}

      16=${orange}
      17=${brown}
    '';
}
