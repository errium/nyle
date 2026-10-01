{...}: {
  config.nyle.targets.foot.template = palette:
    with palette.mnemonic.raw; ''
      [colors-${palette.variant}]
      foreground=${white}
      background=${black}

      regular0=${black}
      regular1=${red}
      regular2=${green}
      regular3=${yellow}
      regular4=${blue}
      regular5=${magenta}
      regular6=${cyan}
      regular7=${white}

      bright0=${darkerBlack}
      bright1=${brightRed}
      bright2=${brightGreen}
      bright3=${brightYellow}
      bright4=${brightBlue}
      bright5=${brightMagenta}
      bright6=${brightCyan}
      bright7=${brightWhite}

      16=${orange}
      17=${brown}
    '';
}
