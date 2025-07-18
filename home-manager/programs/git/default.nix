_: {
  programs.git = {
    enable = true;
    userName = "Shuya Kinjo";
    userEmail = "a8109058@gmail.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        default = "simple";
      };
      core = {
        editor = "vim";
        symlinks = true;
        quotepath = false;
        excludesfile = "~/.config/git/gitignore_global";
      };
    };
  };
  home.file.".config/git/gitignore_global".source = ./gitignore_global;
}
