{
  self,
  pkgs,
  ...
}:
let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      Background = "${self}/assets/pexels-kellie-churchman-371878-1001682.png";
    };
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    extraPackages = with pkgs; [
      custom-sddm-astronaut
    ];
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
    custom-sddm-astronaut
  ];
}
