{user, ...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "/home/${user}/HDD/music";
    playlistDirectory = "/home/${user}/HDD/music";
    network = {
      listenAddress = "127.0.0.1";
      port = 6600;
    };
    extraConfig = ''
      local_permissions "read,add,player,control,admin"
         audio_output {
           type    "pulse"
           name    "PulseAudio"
         }
    '';
  };

  programs.rmpc = {
    enable = true;
  };
}
