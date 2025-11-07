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
     exec ${lib.getExe pkgs.slstatus} -s | ${lib.getExe dwlPackage} -s "swaybg -i ~/.dotfiles/bg/gruvbox_1.jpg &"
  '';
in {
  programs.dwl = {
    enable = true;
    package = dwlPackage;
    extraSessionCommands = ''
      export XKB_DEFAULT_LAYOUT=de;
    '';
  };
  environment.systemPackages = with pkgs; [
    dwlWrapper
    wmenu
    swaybg
  ];
}
