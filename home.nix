{overlays, ...}: {
  home = {
    username = "lukas";
    homeDirectory = "/home/lukas";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  imports = [
    ./modules/hm/fuzzel
    ./modules/hm/term
    ./modules/hm/sh
    ./modules/hm/git
    ./modules/hm/neovim
    ./modules/hm/music
    ./modules/hm/dwl
    ./modules/hm/sway
    ./modules/hm/multiplexer
    ./modules/hm/direnv/direnv.nix
    ./modules/hm/pkgs.nix
    ./modules/shared
  ];
  home.stateVersion = "23.05"; # Please read the comment before changing.
  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
  };
  nixpkgs.overlays = overlays;
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  services.udiskie.enable = true;
}
