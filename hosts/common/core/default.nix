# IMPORTANT: This is used by NixOS and nix-darwin so options must exist in both!
{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}: let
  platform =
    if isDarwin
    then "darwin"
    else "nixos";
  platformModules = "${platform}Modules";
in {
  imports = lib.flatten [
    inputs.home-manager.${platformModules}.home-manager

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/hosts/common"
      "modules/hosts/${platform}"

      "hosts/common/core/${platform}.nix"

      "hosts/common/users"
    ])
  ];

  hostSpec = {
    primaryUsername = "djames";
    username = "djames";
  };

  networking.hostName = config.hostSpec.hostName;

  environment.systemPackages = [pkgs.openssh];

  home-manager.useGlobalPkgs = true;

  home-manager.backupFileExtension = "bak";

  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  # On darwin, it's important this is outside home-manager
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}
