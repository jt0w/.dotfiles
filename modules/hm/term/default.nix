{
  pkgs,
  lib,
  ...
}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "Iosevka Jt0w:size=12,Symbols Nerd Font:size=12";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      cursor = {
        beam-thickness = 2.0;
        style = "block";
      };
    };
  };
  home.packages = with pkgs; [
    nerd-fonts.symbols-only
  ];
}
