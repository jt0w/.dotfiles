{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings.main.terminal = "${pkgs.foot}/bin/foot";
  };
}
