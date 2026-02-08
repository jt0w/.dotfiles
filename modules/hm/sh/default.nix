{...}: {
  programs.bash = {
    enable = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
      cd = "z";
      ci = "zi";
      nix-shell = "nix-shell --command bash";
    };

    initExtra = ''
      __git_prompt() {
        GIT_PROMPT=""
        local branch
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
        GIT_PROMPT=" (''${branch})"
      }

      PROMPT_COMMAND=__git_prompt
      export PS1=' \[\e[00;34m\]λ''${GIT_PROMPT} \W \[\e[0m\]'
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

  programs.zoxide.enable = true;
  programs.yazi.enable = true;
  programs.btop.enable = true;
  programs.lazygit.enable = true;
}
