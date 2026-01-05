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
        border: none;
       border-radius: 0;
      }

      window#waybar {
        background: alpha(@base00, 0.9);
      }

      #tags button {
        color: @base04;
      }

      #tags button:hover {
        color: @base06;
      }

      #tags button.occupied {
        color: @base05;
      }

      #tags button.focused {
        color: @base0E;
      }

      #tags button.urgent {
        color: @base08;
      }

      #cpu, #memory, #pulseaudio, #clock {
        padding: 0px 5px;
        margin:  0px 5px;
      }
    '';
    settings = {
      mainBar = {
        margin = "0 0 0 0";
        position = "bottom";
        height = 20;

        modules-left = ["dwl/tags"];
        modules-center = ["dwl/window"];
        modules-right = ["cpu" "memory" "pulseaudio" "clock"];

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
            "default" = ["" "" ""];
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
      };
    };
  };
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
