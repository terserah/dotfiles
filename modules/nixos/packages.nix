{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    wl-clipboard
    alacritty
    noctalia
    fuzzel
    xwayland-satellite
  ];
}
