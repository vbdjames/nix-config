{ inputs, self, ... }:
let
  specialArgs = {
    inherit inputs self;
  };
in
{
  flake = {
    nixosConfigurations."sophie" = inputs.nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      system = "x86_64-linux";
      modules = [ ./sophie ];
    };
  };
}
