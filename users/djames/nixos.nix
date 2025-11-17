{
  pkgs,
  ...
}:
{
  users.users.djames = {
    isNormalUser = true;
    description = "Doug James";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };
}