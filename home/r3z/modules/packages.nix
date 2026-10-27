{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio
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
