{...}: {
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
      cd = "z";
      ci = "zi";
      nix-shell = "nix-shell --command fish";
    };

    shellAbbrs = {
      # git
      ga = "git add";
      gs = "git status --short";
      gl = "git log";
      gcl = "git clone";
      ghc = {
        setCursor = "$";
        expansion = "git clone https://github.com/$";
      };
      gc = {
        setCursor = "$";
        expansion = "git commit -m '$'";
      };
      gca = {
        setCursor = "$";
        expansion = "git commit -am '$'";
      };
    };

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_config theme choose "Base16 Default Dark" # set theme
      pokeget random --hide-name
    '';
  };

  programs.eza = {
    enable = true;
    colors = "always";
    icons = "always";
    git = true;
    extraOptions = [
      "-lah"
    ];
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$jobs$directory$character";
      right_format = "$all";
    };
  };

  programs.atuin.enable = true;
  programs.zoxide.enable = true;
  programs.yazi.enable = true;
  programs.btop.enable = true;
  programs.lazygit.enable = true;
}
