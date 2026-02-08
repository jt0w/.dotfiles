{
  pkgs,
  lib,
  config,
  ...
}: let
  dwlPackage =
    (pkgs.dwl.override {
      configH = pkgs.replaceVars ./config.def.h {
        base00 = config.lib.stylix.colors.base00;
        base01 = config.lib.stylix.colors.base01;
        base02 = config.lib.stylix.colors.base02;
        base03 = config.lib.stylix.colors.base03;
        base04 = config.lib.stylix.colors.base04;
        base05 = config.lib.stylix.colors.base05;
        base06 = config.lib.stylix.colors.base06;
        base07 = config.lib.stylix.colors.base07;
        base08 = config.lib.stylix.colors.base08;
        base09 = config.lib.stylix.colors.base09;
        base0A = config.lib.stylix.colors.base0A;
        base0B = config.lib.stylix.colors.base0B;
        base0C = config.lib.stylix.colors.base0C;
        base0D = config.lib.stylix.colors.base0D;
        base0E = config.lib.stylix.colors.base0E;
        base0F = config.lib.stylix.colors.base0F;
      };
    }).overrideAttrs
    (old: {
      buildInputs =
        (old.buildInputs or [])
        ++ (with pkgs; [
          fcft
          libdrm
        ]);
      patches = [
        ./patches/bar.patch
        ./patches/bar-appicons.patch
        ./patches/gaps.patch
        ./patches/regions.patch
        ./patches/unclutter.patch
      ];
    });

  dwlWrapper = pkgs.writeScriptBin "dwl" ''
    #!/usr/bin/env sh
    slstatus -s | ${lib.getExe dwlPackage} -s "
      swaybg -i ~/.dotfiles/bgs/gruvbox/Clearnight.jpg &
      wl-paste --watch cliphist store &
      fnott &
      wlr-randr --output HDMI-A-1 --mode 1920x1080@74.973000 &
      "
  '';
in {
  programs.dwl = {
    enable = true;
    package = dwlWrapper;
  };

  environment.systemPackages = with pkgs; [
    wmenu
    swaybg
    slstatus
    wlr-randr
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
