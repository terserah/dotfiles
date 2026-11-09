{ ... }:
{
 
  networking.networkmanager.enable = true;
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "1.1.1.1"
        "9.9.9.9"
      ];
      FallbackDNS = [];
    };
  };
  # Enable edit hosts
  environment.etc.hosts.enable = false;
}
