{
  pkgs,
  flake-dir,
  theme,
  polarity,
  ...
}: {
  stylix.enable = true;
  stylix.image = flake-dir + /bgs/rocky_beach_1.png;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  stylix.polarity = polarity;

  stylix.cursor.package = pkgs.phinger-cursors;
  stylix.cursor.name = "phinger-cursors-dark";
  stylix.cursor.size = 16;

  # stylix.opacity.terminal = 0.8;
  # stylix.opacity.applications = 0.8;
  # stylix.opacity.desktop = 0.8;
  # stylix.opacity.popups = 0.8;

  stylix.fonts = {
    sizes = {
      terminal = 14;
    };
    monospace = {
      name = "Iosevka Jt0w";
      package = pkgs.iosevka.override {
        set = "jt0w";
        privateBuildPlan = {
          family = "Iosevka Jt0w";
          spacing = "term";
          serifs = "sans";
          noCvSs = true;
          exportGlyphNames = false;
          variants = {
            inherits = "ss15";
            weights = {
              extralight = {
                css = 200;
                menu = 200;
                shape = 200;
              };
              light = {
                css = 300;
                menu = 300;
                shape = 300;
              };
              regular = {
                css = 400;
                menu = 400;
                shape = 400;
              };
              medium = {
                css = 500;
                menu = 500;
                shape = 500;
              };
              semibold = {
                css = 600;
                menu = 600;
                shape = 600;
              };
              bold = {
                css = 700;
                menu = 700;
                shape = 700;
              };
            };
          };
        };
      };
    };
  };

  qt.enable = true;
}
