{system, emacs-config, ...}: {
  stylix.targets.emacs.enable = false;
  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = emacs-config.packages.${system}.default;
  };
}
