{
  config,
  pkgs,
  ...
}: {
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;

    style = with config.lib.stylix.colors.withHashtag; ''
      @define-color base00 ${base00};  @define-color base01 ${base01};
      @define-color base02 ${base02};  @define-color base03 ${base03};
      @define-color base04 ${base04};  @define-color base05 ${base05};
      @define-color base06 ${base06};  @define-color base07 ${base07};

      @define-color base08 ${base08};  @define-color base09 ${base09};
      @define-color base0A ${base0A};  @define-color base0B ${base0B};
      @define-color base0C ${base0C};  @define-color base0D ${base0D};
      @define-color base0E ${base0E};  @define-color base0F ${base0F};

        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: Iosevka Jt0w;
          font-size: 15px;
          padding: 0;
        }
        #clock,
        #tray,
        #cpu,
        #memory,
        #pulseaudio {
          margin: 2px 2px 0px 0px;
          padding: 2px 8px;
        }

         window#waybar {
           color: @base05;
           background: @base01;
         }

         window#waybar.empty #window{
           background: none;
         }

         #workspaces button {
           background: @base02;
           color: @base04;
         }

         #workspaces button.focused {
           background: @base05;
           color: @base00;
         }

         #workspaces button:hover {
           background: @base03;
           color: @base05;
         }

         #workspaces button.occupied {
           background: @base02;
           color: @base05;
         }

         #workspaces button.urgent {
           background: @base08;
           color: @base00;
         }
    '';
    settings = {
      mainBar = {
        position = "bottom";
        height = 0;
        spacing = 0;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-center = ["sway/window"];
        modules-right = [
          "tray"
          "cpu"
          "memory"
          "pulseaudio"
          "clock"
        ];

        "pulseaudio" = {
          "scroll-step" = 5;
          "max-volume" = 150;
          "format" = "{volume}% vol";
          "format-bluetooth" = "{volume}% vol";
          "nospacing" = 1;
          "on-click" = "foot -e pulsemixer";
          "tooltip" = false;
        };

        "tray" = {
          "spacing" = 10;
        };

        "cpu" = {
          "format" = "{usage}% cpu";
        };

        "memory" = {
          "format" = "{percentage}% mem";
        };
      };
    };
  };
  home.packages = with pkgs; [
    libnotify
  ];
}
