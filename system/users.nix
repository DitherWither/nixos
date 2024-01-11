{pkgs, ...}: {
  # Even though fish is installed in home-manager, nix doesn't like
  # this not being there
  programs.fish.enable = true;

  users.users.vardhan = {
    description = "Vardhan Patil";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Snable passwordless sudo
  security.sudo.wheelNeedsPassword = false;
}