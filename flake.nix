{
  description = "My Simple NixOS Flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, noctalia, ... }@inputs:
    let
      system = "x86_64-linux";

      mkHost = { hostName, users ? [ ] }: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.hostPlatform = system; }

          ./hosts/${hostName}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users = builtins.listToAttrs (map (user: {
              name = user;
              value = import ./users/${user};
            }) users);
          }
        ];
      };
    in {
      nixosConfigurations = {
        # Host 1: Workstation (User: r3z)
        catnux = mkHost {
          hostName = "catnux";
          users = [ "r3z" ];
        };

        # # Host 2: Laptop Kerja (User: r3z saja)
        # work-laptop = mkHost {
        #   hostName = "work-laptop";
        #   users = [ "r3z" ];
        # };

        # # Host 3: Home Server (User: bob saja)
        # homeserver = mkHost {
        #   hostName = "homeserver";
        #   users = [ "bob" ];
        # };
      };
    };
}