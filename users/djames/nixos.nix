{
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
{

  sops.secrets.example_password.neededForUsers = true;
  # users.mutableUsers = false; # Required for password to be set via sops during system activation

  users.users.djames = {
    isNormalUser = true;
    icon = "${self}/assets/djames.png";
    # hashedPasswordFile = config.sops.secrets.example_password.path;
    description = "Doug James";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}
