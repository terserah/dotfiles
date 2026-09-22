{ config, lib, pkgs, ... }:
{
  # For editing hosts (biar gak capek2 tembah host aja sih)
  system.activationScripts.hosts.text = ''
    if [ ! -f /var/lib/hosts ]; then
      cp /etc/hosts /var/lib/hosts
    fi

    rm -f /etc/hosts
    ln -sf /var/lib/hosts /etc/hosts
  '';

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
}
