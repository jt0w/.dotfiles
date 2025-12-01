{user, ...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "/home/${user}/HDD/music";
    playlistDirectory = "/home/${user}/HDD/music/playlists";
    extraConfig = ''
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
