{
  description = "NixOS Configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = inputs@{ self, nixpkgs, nixos-wsl, home-manager, vscode-server, ... }:
    let
      system = "x86_64-linux";
      version = "24.11";
      hostname = "nixos";
      username = "khangvum";
      dotfiles_path = "/etc/nixos/.dotfiles";

      # Aliases      
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      "${hostname}" = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          nixos-wsl.nixosModules.wsl
          vscode-server.nixosModules.default
        ];
        specialArgs = { 
          inherit system version hostname username dotfiles_path;
        };
      };
    };

    homeConfigurations = {
      "${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = { 
          inherit version username dotfiles_path;
        };
      };
    };
  };
}
