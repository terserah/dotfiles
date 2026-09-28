{ config, lib, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    adwaita-fonts
    corefonts
    vista-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    plus-jakarta-sans
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    fira-code
    fira-code-symbols
    inter
  ];
}
