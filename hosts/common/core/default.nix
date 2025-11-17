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
  platform = if isDarwin then "darwin" else "nixos";
  platformModules = "${platform}Modules";
in
{
  imports = lib.flatten [
    inputs.home-manager.${platformModules}.home-manager
    (map lib.custom.relativeToRoot [
      "hosts/common/core/${platform}.nix"
    ])
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";
  
  home-manager.extraSpecialArgs = {
    inherit inputs;
    firefox-addons-allowUnfree = pkgs.callPackage inputs.firefox-addons { };
  };
}
