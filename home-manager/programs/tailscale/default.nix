{
  config,
  ...
}:
{
  config = {
    programs.zsh.initContent = ''
      # Tailscale PATH (Homebrew)
      export PATH="/opt/homebrew/bin:$PATH"
    '';
  };
}
