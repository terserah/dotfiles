{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio
    jetbrains.datagrip
    vscode
    nautilus
    mpv
    pandoc
    # scheme-small + paket untuk code block dan inline code di PDF.
    (texliveSmall.withPackages (ps: [
      ps.tcolorbox
      ps.pdfcol
      ps.fvextra
      ps.float
      ps.lua-ul
      ps.luacolor
      ps.lualatex-math
      ps.selnolig
    ]))
    loupe
    libreoffice
    unzip
    p7zip
    jdk
    jq
    wl-mirror 
    nodejs
  ];
  
}
