_: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Shuya Kinjo";
        email = "a8109058@gmail.com";
      };
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
