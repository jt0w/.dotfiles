{
  pkgs,
  lib,
  ...
}: let
  dwlPackage =
    (pkgs.dwl.override {
      configH = ./config.def.h;
    }).overrideAttrs (old: {
      patches = lib.filesystem.listFilesRecursive ./patches;
      buildInputs =
        (old.buildPackages or [])
        ++ (with pkgs; [
          wayland
          wayland-protocols
          wayland-scanner
          libinput
          pixman
          libxkbcommon
          libdrm
          fcft
          wlroots_0_18
          xorg.xcbutilwm # for xcb-icccm
          xorg.xcbutil # for basic xcb
          pkg-config
        ]);
    });


  dwlWrapper = pkgs.writeScriptBin "dwlWrapper" ''
    #!/usr/bin/env sh
    exec ${lib.getExe dwlPackage}
  '';
in {
  programs.dwl = {
    enable = true;
    package = dwlWrapper;
    extraSessionCommands = ''
      export XKB_DEFAULT_LAYOUT=de;
    '';
  };
  environment.systemPackages = with pkgs; [
    dwlPackage
    wmenu
    swaybg
 ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs;[xdg-desktop-portal-gtk];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
