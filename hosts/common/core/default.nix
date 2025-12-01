{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  # platform = if isDarwin then "darwin" else "nixos";
  platform = "nixos";
  platformModules = "${platform}Modules";
in
{
  imports = lib.flatten [
    inputs.sops-nix.${platformModules}.sops
    ../core/nixos.nix
    # (map lib.custom.relativeToRoot [
    # "hosts/common/core/${platform}.nix"
    # ])
  ];

  sops = {
    # defaultSopsFile = (lib.custom.relativeToRoot "secrets/secrets.yaml");
    defaultSopsFile = ../../../secrets/secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    # secrets will be output to /run/secrets
    # e.g. /run/secrets/hello
    # secrets required for user creation are handled in respective ./users/username.nix files
    # because they will be output to /run/secrets-for-users and only when the user is assigned to a host.
    # This is from the video, and not guaranteed to be true yet
    secrets = {
      hello = { };
    };
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
    firefox-addons-allowUnfree = pkgs.callPackage inputs.firefox-addons { };
  };

  environment.systemPackages = [
    pkgs.just
  ];
}
