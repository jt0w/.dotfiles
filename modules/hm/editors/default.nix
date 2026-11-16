{
  inputs,
  system,
  pkgs,
  theme,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  stylix.targets.emacs.enable = false;
  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = inputs.emacs-config.packages.${system}.default;
  };

  home.packages = with pkgs; [
    (inputs.neovim-config.packages.${system}.default.override {
      base16-theme = theme;
    })

    # 08/02/2026: TODO: these dont actually work
    (typst.withPackages (
      p:
        with p; [
          cetz # drawing
          codly # code
          fletcher # diagrams
          frame-it # frames
          hydra # headings
          pinit # pining
          touying # slides
          lilaq
          herodot
          basic-resume
        ]
    ))
  ];
}
