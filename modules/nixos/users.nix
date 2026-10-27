{ pkgs, ... }:
{
  programs.zsh.enable = true;

  users.users.r3z = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "disk"
      "docker"
      "libvirtd"
    ];
    packages = with pkgs; [
      tree
      less
      htop
    ];
  };
}
