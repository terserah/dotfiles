{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio
    vscode
    nautilus
    libreoffice
    unzip
    p7zip
    jdk
    jq
    wl-mirror 
    nodejs
  ];
}
