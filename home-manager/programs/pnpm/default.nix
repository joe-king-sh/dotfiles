{ config, ... }:
{
  home.file.".config/pnpm/rc".text = ''
    minimum-release-age=30240
  '';
}
