{pkgs, ...}: {
  nix = {
    settings =  {
      # Enable flakes
      experimental-features = [ "nix-command" "flakes" ];

      trusted-users = ["vardhan"];
      extra-substituters = ["https://nix-community.cachix.org"];
      extra-trusted-public-keys = [
        # cachix's public key
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Git is used to fetch flakes
  environment.systemPackages = with pkgs; [
    git
  ];
}