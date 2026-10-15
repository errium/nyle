{config, ...}: {
  config.nyle.targets.alacritty.template = with config.lib.nyle.mnemonic.hex; ''
    [colors.primary]
    background = '${black}'
    foreground = '${white}'

    [colors.normal]
    black   = '${black}'
    red     = '${red}'
    green   = '${green}'
    yellow  = '${yellow}'
    blue    = '${blue}'
    magenta = '${magenta}'
    cyan    = '${cyan}'
    white   = '${white}'

    [colors.bright]
    black   = '${darkerBlack}'
    red     = '${brightRed}'
    green   = '${brightGreen}'
    yellow  = '${brightYellow}'
    blue    = '${brightBlue}'
    magenta = '${brightMagenta}'
    cyan    = '${brightCyan}'
    white   = '${brightWhite}'

    [[colors.indexed_colors]]
    index = 16
    color = '${orange}'

    [[colors.indexed_colors]]
    index = 17
    color = '${brown}'
  '';
}
