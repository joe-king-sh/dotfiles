{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    home.sessionPath = [ "$HOME/.rd/bin" ];

    programs.zsh.initExtra = ''
      # Rancher Desktop PATH
      export PATH="$HOME/.rd/bin:$PATH"
    '';
  };
}
