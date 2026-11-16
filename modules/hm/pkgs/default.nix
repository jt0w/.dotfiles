{pkgs, ...}: {
  home.packages = [
    # (pkgs.callPackage ./mindustry.nix {enableWayland = true;})
  ];
}
