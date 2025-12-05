{
  pkgs, 
  self, 
  ...
}:
{
  users.users.djames = {
    isNormalUser = true;
    icon = "${self}/assets/djames.png";
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

  home-manager.users.djames = {
    imports = [ "${self}/users/djames/home.nix" ];
  };
}