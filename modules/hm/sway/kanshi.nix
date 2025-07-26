{...}: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "PC";
          outputs = [
            {
              criteria = "HDMI-A-1";
              mode = "1920x1080@75Hz";
              position = "0,0";
            }
            {
              criteria = "DP-1";
              mode = "1920x1080@60Hz";
              position = "1920,0";
            }
          ];
        };
      }
    ];
  };
}
