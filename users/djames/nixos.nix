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

}
