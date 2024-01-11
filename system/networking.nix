{pkgs, ...}: {
  networking = {
    hostName = "15s-laptop";
    domain = "vardhanpatil.com";

    # DNS over TLS config, pass dns requests to dnscrypt
    nameservers = ["127.0.0.1" "::1"];

    # Enable networking
    networkmanager.enable = true;
    networkmanager.dns = "none";
  };

  # DNSCrypt
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      cache = true;
      cache_size = 4096;
      cache_min_ttl = 2400;
      cache_max_ttl = 86400;
      cache_neg_min_ttl = 60;
      cache_neg_max_ttl = 600;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      server_names = [ "cloudflare" ];
    };
  };
  systemd.services.cloudflare-warp.enable = true;
  systemd.services.warp-svc = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = ["NetworkManager-wait-online.service"];
    description = "Start up warp-svc";
    serviceConfig = {
      ExecStart = "${pkgs.cloudflare-warp}/bin/warp-svc";
    };
  };
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  environment.systemPackages = [
    pkgs.cloudflare-warp
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}