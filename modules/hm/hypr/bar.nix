{
  pkgs,
  config,
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
        font-family: JetBrainsMono Nerd Font Propo;
        font-size: 15px;
        font-weight: bold;
      }

      window#waybar {
        border-radius: 0.6rem;
        border: 2px solid @base06;
        color: @base05;
        background: alpha(@base01, 0.8);
      }

      window#waybar.empty #window{
        background: none;
      }

      #workspaces {
        background: transparent;
        margin: 5px 10px;
        padding: 0px 0px;
        border-radius: 15px;
      }

      #workspaces button {
        background: @base02;
        color: @base04;
        border: none;
        border-radius: 8px;
        min-width: 15px;
        margin: 2px 3px;
        padding: 4px 8px;
        transition: background-color 0.3s ease, color 0.3s ease, padding 0.3s ease, min-width 0.3s ease;
      }

      #workspaces button.active {
        background: @base05;
        color: @base00;
        box-shadow: 0 2px 8px @base01;
        padding: 4px 8px;
        min-width: 25px;
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

      #custom-power {
        padding: 5px 8px;
        margin:  5px 5px;
      }
    '';
    settings = {
      mainBar = {
        margin = "5 10 0 10";
        position = "top";
        height = 42;

        modules-left = [
          "hyprland/workspaces"
          "wlr/taskbar"
        ];
        modules-center = ["hyprland/window"];
        modules-right = [
          "tray"
          "cpu"
          "memory"
          "pulseaudio"
          "clock"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          "format" = "{name}";
          "on-click" = "activate";
          "sort-by-number" = true;
          "active-only" = false;
        };

        "wlr/taskbar" = {
          "on-click" = "activate";
          "on-click-right" = "minimize-raise";
          "on-click-middle" = "close";
        };

        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{volume}% {icon}  {format_source}";
          "format-bluetooth" = "{volume}% {icon}  {format_source}";
          "format-bluetooth-muted" = "󰸈 {icon}  {format_source}";
          "format-muted" = "󰸈 {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = " ";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };

          "on-click" = "pavucontrol";
        };
        "tray" = {
          "icon-size" = 21;
          "spacing" = 15;
        };
        "cpu" = {
          "format" = "{usage}% ";
        };
        "memory" = {
          "format" = "{percentage}% ";
        };
        "custom/power" = {
          "format" = "";
          "on-click" = "wlogout";
        };
      };
    };
  };
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
