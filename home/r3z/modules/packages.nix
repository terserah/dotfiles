{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio
    jetbrains.datagrip
    vscode
    nautilus
    mpv
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
