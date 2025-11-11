# Nix settings that are common to hosts and home-manager configs
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };

  nix = {
    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
      gc = {
        automatic = true;
        options = "--delete-older-than 10d";
      };
    };
  };
}
