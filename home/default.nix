{ pkgs, ...}: {
  home.username = "vardhan";
  home.homeDirectory = "/home/vardhan";

  home.packages = with pkgs; [
    # GUI Programs
    google-chrome
    discord
    firefox

    # Development tools
    vscode-fhs
    nil
    jdk17
    jetbrains.idea-ultimate

    # Utils
    bat
    eza
    ripgrep
    ripgrep-all
    trashy

    # Archives
    zip
    unzip
    p7zip

    # Misc
    neofetch
    tree

    # Networking
    dnsutils
    aria2
    wget

    # Monitoring
    lm_sensors
    pciutils
    usbutils

    prismlauncher
  ];

  programs = {
    fish = {
      enable = true;
      shellAliases = {
        nce = "code /etc/nixos/";
        nrb = "sudo nixos-rebuild switch --flake /etc/nixos";
      };
    };
    bash.enable = true;
    eza = {
      enable = true;
      enableAliases = true;
    };
    git = {
      enable = true;
      userName = "Vardhan Patil";
      userEmail = "hi@vardhanpatil.com";
    };
    home-manager.enable = true;
    ripgrep.enable = true;
    bat.enable = true;
  };


  home.stateVersion = "23.11";
}