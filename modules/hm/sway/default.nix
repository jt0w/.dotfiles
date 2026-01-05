{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./bar.nix
    ./kanshi.nix
  ];
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    extraOptions = [
      "--unsupported-gpu"
    ];
    config = {
      window = {
        titlebar = false;
        hideEdgeBorders = "smart";
      };
      startup = [
        {
          always = true;
          command = "wl-copy";
        }
        {
          always = true;
          command = "ghostty --initial-window=false";
        }
      ];
      bars = [
        (
          {
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
            fonts = {
              names = ["FontAwesome" "JetBrainsMono"];
              style = "Bold";
              size = 10.0;
            };
          }
          // config.stylix.targets.sway.exportedBarConfig
        )
      ];
      gaps = {
        inner = 2;
        outer = 4;
      };

      input = {
        "*" = {
          xkb_layout = "de";
        };
      };

      modifier = "Mod4";
      terminal = "ghostty";
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
        terminal = config.wayland.windowManager.sway.config.terminal;
        filemanager = "thunar";
        browser = "librewolf";
      in
        lib.mkOptionDefault {
          "${mod}+Return" = "exec ${terminal}";
          "${mod}+shift+f" = "exec ${filemanager}";
          "${mod}+b" = "exec ${browser}";
          "${mod}+q" = "kill";
          "${mod}+d" = "exec fuzzel -f 'JetBrainsMono Nerd Font Mono'-16";
          "${mod}+v" = "exec cliphist list | fuzzel -d -f 'JetBrainsMono Nerd Font Mono'-16 | cliphist decode | wl-copy";
          "${mod}+t" = "exec grim ~/HDD/Pictures/$(date +'screenshot_%Y-%m-%d-%H%M%S.png')";
          "${mod}+shift+t" = "exec slurp | grim -g - ~/HDD/Pictures/$(date +'screenshot_%Y-%m-%d-%H%M%S.png')";
          "${mod}+a" = "exec foot -e pulsemixer";
        };
    };
  };
  home.packages = with pkgs; [
    wl-clipboard
    slurp
    grim
  ];
  services.fnott.enable = true;
  services.autotiling.enable = true;
}
