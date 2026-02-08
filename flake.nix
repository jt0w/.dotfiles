{
  description = "My NixOs Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix";
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    kix = {
      url = "github:jt0w/kix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-config.url = "github:jt0w/.nvim";
    musnix = {
      url = "github:musnix/musnix";
    };

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    stylix,
    ghostty,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    flake-dir = ./.;
    overlays = [
    ];
    theme = "tender";
    polarity = "dark";
    user = "lukas";
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit overlays;
          inherit flake-dir;
          inherit theme;
          inherit polarity;
        };
        modules = [
          ./configuration.nix
          stylix.nixosModules.stylix
          inputs.musnix.nixosModules.musnix
        ];
      };
    };
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        stylix.homeModules.stylix
        inputs.nur.modules.homeManager.default
        inputs.arkenfox.hmModules.arkenfox

        ./home.nix
      ];
      extraSpecialArgs = {
        inherit inputs;
        inherit overlays;
        inherit ghostty;
        inherit flake-dir;
        inherit system;
        inherit theme;
        inherit polarity;
        inherit user;
      };
    };
  };
}
