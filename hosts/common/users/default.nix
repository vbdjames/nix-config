{
  inputs,
  pkgs,
  config,
  lib,
  isDarwin,
  ...
}:

let
  platform = if isDarwin then "darwin" else "nixos";
  hostSpec = config.hostSpec;
in
{
  # No matter what environment we are in we want these tools for root and all users
  programs.zsh.enable = true;
  programs.git.enable = true;
  environment = {
    systemPackages = [
      pkgs.just
      pkgs.rsync
    ];
  };

  users = {
    users = 
      (lib.mergeAttrsList
        (
          map (user: {
            "${user}" = 
            let
              platformPath = lib.custom.relativeToRoot "hosts/common/users/${user}/${platform}.nix";
            in
            {
              name = user;
              shell = pkgs.zsh;
              home = if IsDarwin then "/Users/${user}" else "/home/${user}";
            };
          }) config.hostSpec.users
        )
      )
  };
}

  home-manager = 
    let
      fullPathIfExists = 
        path:
        let
          fullPath = lib.custom.relativeToRoot path;
        in
          lib.optional (lib.pathExists fullPath) fullPath;
    in
    {
        
    }