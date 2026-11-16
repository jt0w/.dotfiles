{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    settings = {
      user = {
        email = "108518296+jt0w@users.noreply.github.com";
        name = "jt0w";
      };
      credentials = {
        "https://github.com".helper = "!/home/lukas/.nix-profile/bin/gh auth git-credential";
        "https://gist.github.com".helper = "!/home/lukas/.nix-profile/bin/gh auth git-credential";
      };
    };
  };
}
