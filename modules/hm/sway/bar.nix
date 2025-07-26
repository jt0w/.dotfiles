{
  config,
  pkgs,
  ...
}: {
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        settings.theme = {
          theme = "plain";
          overrides =
            config.lib.stylix.i3status-rust.bar
            // (with config.lib.stylix.colors.withHashtag; {
              idle_bg = base01;
              separator_bg = base01;
            });
        };
        icons = "awesome6";
        blocks = [
          {block = "music";}
          {block = "cpu";}
          {block = "memory";}
          {block = "nvidia_gpu";}
          {block = "uptime";}
          {
            block = "temperature";
            good = 40;
            idle = 60;
            info = 65;
          }
          {
            block = "sound";
            format = "$icon $output_name{ $volume|}";
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            interval = 60;
          }
        ];
      };
    };
  };
  home.packages = with pkgs; [
    libnotify
  ];
}
