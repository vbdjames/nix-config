{ lib, ... }: {

  services.flatpak.enable = true;
  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;

  services.flatpak.packages = [
    "md.obsidian.Obsidian"
  ];
}
