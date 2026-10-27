{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dnsmasq
    vim
    wget
    wl-clipboard
    alacritty
    noctalia
    fuzzel
    xwayland-satellite
  ];
}
