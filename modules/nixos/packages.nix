{ pkgs, ... }:
{
  programs.zoom-us.enable = true;
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };
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
