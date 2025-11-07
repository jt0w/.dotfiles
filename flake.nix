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
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";

    kix = {
      url = "github:secretval/kix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-config = {
      url = "github:secretval/.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {url = "github:musnix/musnix";};

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kanagawa = {
      url = "github:rebelot/kanagawa.nvim";
      flake = false;
    };

    winboat.url = "github:TibixDev/winboat";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    stylix,
    hyprland-qtutils,
    ghostty,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    flake-dir = ./.;
    overlays = [
    ];
    theme = "gruber";
    polarity = "dark";
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit overlays;
          inherit hyprland-qtutils;
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
    homeConfigurations."lukas" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        stylix.homeModules.stylix
        inputs.nur.modules.homeManager.default

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
      };
    };
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        wayland
        wayland-protocols
        wayland-scanner
        libinput
        pixman
        libxkbcommon
        libdrm
        fcft
        wlroots
        pkg-config
      ];
    };
  };
}
